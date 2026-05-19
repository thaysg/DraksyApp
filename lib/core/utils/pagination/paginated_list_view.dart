// lib/core/utils/pagination/paginated_list_view.dart

import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';
import '../../mixins/pagination_scroll_mixin.dart';

class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView({
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.onLoadMore,
    required this.itemBuilder,
    super.key,
    this.onRefresh,
    this.onRetryInitial,
    this.onRetryPagination,
    this.initialError,
    this.paginationError,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
    this.emptyWidget,
    this.loadingWidget,
    this.errorWidget,
    this.header,
    this.footer,
    this.padding,
  });
  final List<T> items;
  final bool isLoading;

  /// Explicit page loading state during pagination.
  final bool isLoadingMore;

  final bool hasMore;

  /// Error to load initial data (empty list).
  final String? initialError;

  /// Error when paginating (list already has items).
  final String? paginationError;

  final Future<void> Function() onLoadMore;
  final Future<void> Function()? onRefresh;

  /// Called when the retry button in the initial error state is pressed.
  final VoidCallback? onRetryInitial;

  /// Called when the retry button in the pagination error state is pressed.
  final VoidCallback? onRetryPagination;

  final Widget Function(BuildContext, T) itemBuilder;

  /// Separator between items. When provided, uses [ListView.separated].
  final Widget Function(BuildContext, int)? separatorBuilder;

  // — Layout —
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  /// [ScrollController] externo opcional.
  ///
  /// Useful for synchronizing scrolling with a collapsible [AppBar] or
  ///  [NestedScrollView].
  /// When not provided, the mixin creates and manages its own controller.
  final ScrollController? controller;

  // — Customization of states (design system) —
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  /// Optional header widget shown before the list items.
  final Widget? header;

  /// Optional footer widget shown after the list items but before
  /// the pagination footer.
  final Widget? footer;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>>
    with PaginationScrollMixin<PaginatedListView<T>> {
  @override
  void initState() {
    super.initState();

    setupPaginationScroll(
      onLoadMore: () => widget.onLoadMore(),
      hasMore: () => widget.hasMore,
      isLoading: () => widget.isLoading,
      onRefresh: widget.onRefresh != null ? () => widget.onRefresh!() : null,
      // Pass the external controller when provided; the mixin manages
      // the lifecycle
      // only of the controllers it created itself.
      controller: widget.controller,
    );
  }

  @override
  void didUpdateWidget(covariant PaginatedListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // The callbacks are resolved via closure in initState, so rebuilds
    // normal (isLoading, hasMore, items) don't need action here.
    //
    // The only exception is the change of the external controller: this is
    // not covered
    // by the closures and requires reconfiguration of the mixin.
    //
    // Note: changing the controller at runtime is not a common pattern and is
    // not generally recommended.
    assert(
      oldWidget.controller == widget.controller,
      'Change the ScrollController externally at runtime is not supported. '
      'Use a key to recreate the widget if you need to change the controller.',
    );
  }

  // ─────────────────────────────────────────────
  // Fullscreen states
  // ─────────────────────────────────────────────

  Widget get _buildLoadingState =>
      widget.loadingWidget ?? const Center(child: CircularProgressIndicator());

  Widget get _buildEmptyState =>
      widget.emptyWidget ?? const Center(child: Text('No items'));

  Widget _buildInitialErrorState(String message) =>
      widget.errorWidget ??
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            if (widget.onRetryInitial != null)
              ElevatedButton(
                onPressed: widget.onRetryInitial,
                child: const Text('Retry'),
              ),
          ],
        ),
      );

  // ─────────────────────────────────────────────
  // Pagination footer
  // ─────────────────────────────────────────────

  Widget _buildFooter() {
    // Pagination error: only shows when there are already items in the list.
    if (widget.paginationError != null && widget.items.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.paginationError!, textAlign: TextAlign.center),
            if (widget.onRetryPagination != null)
              TextButton(
                onPressed: widget.onRetryPagination,
                child: const Text('Retry'),
              ),
          ],
        ),
      );
    }

    // Explicit loading state for pagination — without ambiguity with hasMore.
    if (widget.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return const SizedBox.shrink();
  }

  // ─────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final hasHeader = widget.header != null;
    final hasFooter = widget.footer != null;

    if (widget.isLoading && widget.items.isEmpty) {
      return hasHeader
          ? ListView(
              controller: scrollController,
              physics: widget.physics ?? const BouncingScrollPhysics(),
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: context.horizontalPadding,
                    vertical: 20,
                  ),
              children: [
                widget.header!,
                _buildLoadingState,
              ],
            )
          : _buildLoadingState;
    }

    if (widget.initialError != null && widget.items.isEmpty) {
      return hasHeader
          ? ListView(
              controller: scrollController,
              physics: widget.physics ?? const BouncingScrollPhysics(),
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: context.horizontalPadding,
                    vertical: 20,
                  ),
              children: [
                widget.header!,
                _buildInitialErrorState(widget.initialError!),
              ],
            )
          : _buildInitialErrorState(widget.initialError!);
    }

    final itemsCount = widget.items.length;
    final totalCount =
        itemsCount + (hasHeader ? 1 : 0) + (hasFooter ? 1 : 0) + 1;

    if (itemsCount == 0 && !widget.isLoading) {
      return hasHeader
          ? ListView(
              controller: scrollController,
              physics: widget.physics ?? const BouncingScrollPhysics(),
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: context.horizontalPadding,
                    vertical: 20,
                  ),
              children: [
                widget.header!,
                _buildEmptyState,
              ],
            )
          : _buildEmptyState;
    }

    final list = ListView.builder(
      controller: scrollController,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics ?? const BouncingScrollPhysics(),
      padding: widget.padding ??
          EdgeInsets.symmetric(
            horizontal: context.horizontalPadding,
            vertical: 20,
          ),
      itemCount: totalCount,
      itemBuilder: (context, index) {
        var adjustedIndex = index;

        if (hasHeader) {
          if (index == 0) {
            return widget.header!;
          }
          adjustedIndex--;
        }

        if (adjustedIndex >= 0 && adjustedIndex < itemsCount) {
          final item = widget.itemBuilder(context, widget.items[adjustedIndex]);
          if (widget.separatorBuilder != null &&
              adjustedIndex < itemsCount - 1) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                item,
                widget.separatorBuilder!(context, adjustedIndex),
              ],
            );
          }
          return item;
        }

        adjustedIndex -= itemsCount;

        if (hasFooter && adjustedIndex == 0) {
          return widget.footer!;
        }

        return _buildFooter();
      },
    );

    if (widget.onRefresh != null) {
      return RefreshIndicator(onRefresh: refresh, child: list);
    }

    return list;
  }
}
