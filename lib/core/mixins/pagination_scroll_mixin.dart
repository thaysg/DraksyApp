import 'dart:async';

import 'package:flutter/material.dart';

/// A mixin that adds infinite-scroll pagination and pull-to-refresh behavior
/// to any [StatefulWidget].
///
/// ## Usage
///
/// ```dart
/// class _MyListState extends State<MyList> with PaginationScrollMixin<MyList>
/// S{
///   @override
///   void initState() {
///     super.initState();
///     setupPaginationScroll(
///       onLoadMore: _fetchNextPage,
///       hasMore: () => _hasMoreItems,
///       isLoading: () => _isLoading,
///       onRefresh: _refresh,
///     );
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return ListView.builder(
///       controller: scrollController,
///       ...
///     );
///   }
/// }
/// ```
mixin PaginationScrollMixin<T extends StatefulWidget> on State<T> {
  ScrollController? _scrollController;

  /// Whether this mixin created the [ScrollController] and is responsible
  /// for disposing it.
  bool _ownsController = false;

  /// Guards against calling [setupPaginationScroll] more than once, which
  /// would attach duplicate listeners to the controller.
  bool _isSetup = false;

  /// Prevents overlapping [_onLoadMore] calls.
  bool _isLoadingMore = false;

  /// Prevents overlapping [_onRefresh] calls.
  bool _isRefreshing = false;

  /// Tracks the scroll offset at which the last load-more was triggered, so
  /// we avoid firing again at nearly the same position.
  double _lastTriggerOffset = 0;

  Timer? _debounce;

  // --- Callbacks ---
  late Future<void> Function() _onLoadMore;
  late bool Function() _hasMore;
  late bool Function() _isLoading;
  Future<void> Function()? _onRefresh;

  // --- Configuration ---
  /// 0.0 = top, 1.0 = bottom. Load-more runs when [ScrollPosition.pixels] /
  /// [ScrollPosition.maxScrollExtent] reaches this fraction (default 70%).
  double _loadMoreTriggerScrollFraction = 0.7;

  /// Used only by [isNearBottom] (distance from bottom in pixels).
  double _nearBottomThresholdPixels = 200;

  Duration _debounceDuration = const Duration(milliseconds: 200);

  // ─────────────────────────────────────────────
  // Public API
  // ─────────────────────────────────────────────

  /// The [ScrollController] to attach to your scrollable widget.
  ///
  /// Must not be accessed before [setupPaginationScroll] is called.
  ScrollController get scrollController {
    assert(
      _isSetup,
      'scrollController accessed before setupPaginationScroll(). '
      'Call setupPaginationScroll() inside initState().',
    );
    return _scrollController!;
  }

  /// Initialises the mixin. Must be called once inside [State.initState].
  ///
  /// - [onLoadMore]  : async callback that fetches the next page.
  /// - [hasMore]     : returns `true` while more pages are available.
  /// - [isLoading]   : returns `true` while an external load is in progress
  ///                   (e.g. the first-page load driven by a Notifier/Provider).
  /// - [onRefresh]   : optional async callback for pull-to-refresh.
  /// - [controller]  : supply an existing [ScrollController] to share it;
  ///                   omit to let the mixin create and own one.
  /// - [loadMoreTriggerScrollFraction] : load more once the user has scrolled
  ///   this fraction of the total scroll extent (e.g. `0.7` = 70% down
  /// the list).
  ///   Must be in `(0, 1]`.
  /// - [nearBottomThresholdPixels] : used only by [isNearBottom] (pixels
  /// from end).
  /// - [debounceDuration] : **Trailing** debounce for scroll notifications. If
  ///   non-zero, load-more is evaluated only after the scroll position has been
  ///   stable for this duration (can feel delayed while the user is still
  ///  moving).
  ///   Use [Duration.zero] to evaluate on every scroll tick (snappier;
  /// duplicate
  ///   loads are still guarded by [_isLoadingMore] and notifier loading state).
  void setupPaginationScroll({
    required Future<void> Function() onLoadMore,
    required bool Function() hasMore,
    required bool Function() isLoading,
    Future<void> Function()? onRefresh,
    ScrollController? controller,
    double loadMoreTriggerScrollFraction = 0.7,
    double nearBottomThresholdPixels = 200,
    Duration debounceDuration = const Duration(milliseconds: 200),
  }) {
    assert(!_isSetup, 'setupPaginationScroll() must only be called once.');
    assert(
      loadMoreTriggerScrollFraction > 0 && loadMoreTriggerScrollFraction <= 1,
      'loadMoreTriggerScrollFraction must be in (0, 1]',
    );

    _onLoadMore = onLoadMore;
    _hasMore = hasMore;
    _isLoading = isLoading;
    _onRefresh = onRefresh;
    _loadMoreTriggerScrollFraction = loadMoreTriggerScrollFraction;
    _nearBottomThresholdPixels = nearBottomThresholdPixels;
    _debounceDuration = debounceDuration;

    _ownsController = controller == null;
    _scrollController = controller ?? ScrollController();
    _scrollController!.addListener(_onScroll);

    _isSetup = true;
  }

  /// Triggers a refresh, resetting pagination state afterwards.
  ///
  /// No-op when no refresh callback was provided or a refresh is
  ///  already running.
  Future<void> refresh() async {
    if (_onRefresh == null || _isRefreshing) {
      return;
    }

    _isRefreshing = true;

    try {
      await _onRefresh!();
      _lastTriggerOffset = 0;
    } catch (e, st) {
      debugPrint('PaginationScrollMixin.refresh error: $e\n$st');
    } finally {
      if (mounted) {
        _isRefreshing = false;
      }
    }
  }

  /// Manually clears the load-more lock.
  ///
  /// Useful when you want to allow retrying after a handled error without
  /// waiting for the next scroll event.
  ///
  /// Set [resetOffset] to `true` to also clear the last trigger position,
  /// forcing the next scroll check to re-evaluate from scratch.
  void resetPaginationLock({bool resetOffset = false}) {
    _isLoadingMore = false;
    if (resetOffset) {
      _lastTriggerOffset = 0;
    }
  }

  // ─────────────────────────────────────────────
  // Scroll position helpers
  // ─────────────────────────────────────────────

  /// `true` if the scroll position is within [_nearBottomThresholdPixels]
  /// Sof the bottom.
  bool get isNearBottom {
    final pos = _positionOrNull;
    if (pos == null) {
      return false;
    }
    return (pos.maxScrollExtent - pos.pixels) <= _nearBottomThresholdPixels;
  }

  /// `true` if the scroll position is at the very top.
  bool get isAtTop => (_positionOrNull?.pixels ?? 0) <= 0;

  /// `true` if the scroll position is at the very bottom.
  bool get isAtBottom {
    final pos = _positionOrNull;
    if (pos == null) {
      return false;
    }
    return pos.pixels >= pos.maxScrollExtent;
  }

  /// Animates the list to the top.
  void scrollToTop({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) {
    final c = _scrollController;
    if (c?.hasClients == true) {
      c!.animateTo(0, duration: duration, curve: curve);
    }
  }

  /// Animates the list to the current bottom extent.
  ///
  /// **Note:** in infinite / lazy lists the extent grows as new items render.
  /// If you need to jump to the absolute bottom after new items are added,
  /// call this inside a [WidgetsBinding.addPostFrameCallback] so the extent
  /// has already been updated.
  void scrollToBottom({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) {
    final pos = _positionOrNull;
    if (pos != null) {
      _scrollController!.animateTo(
        pos.maxScrollExtent,
        duration: duration,
        curve: curve,
      );
    }
  }

  // ─────────────────────────────────────────────
  // Internal helpers
  // ─────────────────────────────────────────────

  ScrollPosition? get _positionOrNull {
    final c = _scrollController;
    return (c != null && c.hasClients) ? c.position : null;
  }

  void _onScroll() {
    if (_scrollController?.hasClients != true) {
      return;
    }
    if (_debounceDuration <= Duration.zero) {
      _handleScroll();
    } else {
      _debounce?.cancel();
      _debounce = Timer(_debounceDuration, _handleScroll);
    }
  }

  void _handleScroll() {
    final pos = _positionOrNull;
    if (pos == null) {
      return;
    }

    if (_isLoadingMore || _isRefreshing) {
      return;
    }

    // When the list does not yet fill the viewport, maxScrollExtent is 0.
    // Trigger a load so the list can grow to fill the screen.
    if (pos.maxScrollExtent <= 0) {
      if (_hasMore() && !_isLoading() && !_isLoadingMore) {
        _triggerLoadMore(pos.pixels);
      }
      return;
    }

    final scrollFraction = pos.pixels / pos.maxScrollExtent;

    // Only re-trigger if the user has scrolled at least 50 px from the last
    // trigger point, preventing duplicate calls at the same position.
    final isNewTriggerPosition = (pos.pixels - _lastTriggerOffset).abs() > 50;

    if (scrollFraction >= _loadMoreTriggerScrollFraction &&
        isNewTriggerPosition &&
        _hasMore() &&
        !_isLoading()) {
      _triggerLoadMore(pos.pixels);
    }
  }

  void _triggerLoadMore(double currentOffset) {
    _lastTriggerOffset = currentOffset;
    _loadMore();
  }

  Future<void> _loadMore() async {
    _isLoadingMore = true;

    try {
      await _onLoadMore();
    } catch (e, st) {
      debugPrint('PaginationScrollMixin.loadMore error: $e\n$st');
    } finally {
      if (mounted) {
        _isLoadingMore = false;
      }
    }
  }

  // ─────────────────────────────────────────────
  // Lifecycle
  // ─────────────────────────────────────────────

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController?.removeListener(_onScroll);
    if (_ownsController) {
      _scrollController?.dispose();
    }
    super.dispose();
  }
}
