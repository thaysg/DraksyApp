import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/utils/pagination/paginated_list_view.dart';
import '../../domain/entities/lesson_unit_data.dart';
import '../providers/lesson_path_provider.dart';
import 'lesson_path_trail.dart';
import 'lessons_list_view.dart';

class LessonPathMap extends ConsumerStatefulWidget {
  const LessonPathMap({
    required this.units,
    required this.levelName,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    this.initialError,
    this.paginationError,
    super.key,
  });

  final List<LessonUnitData> units;
  final String levelName;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? initialError;
  final String? paginationError;

  @override
  ConsumerState<LessonPathMap> createState() => _LessonPathMapState();
}

class _LessonPathMapState extends ConsumerState<LessonPathMap> {
  late final ScrollController _scrollController;
  bool _hasScrolledToCurrent = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Scroll if units are already available
    if (widget.units.isNotEmpty) {
      _scrollToCurrentLesson();
    }
  }

  @override
  void didUpdateWidget(covariant LessonPathMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset flag if units were cleared (e.g. during a refresh/invalidate)
    if (widget.units.isEmpty && oldWidget.units.isNotEmpty) {
      _hasScrolledToCurrent = false;
    }

    if (widget.units.isNotEmpty && !_hasScrolledToCurrent) {
      _scrollToCurrentLesson();
    }
  }

  void _scrollToCurrentLesson() {
    final notifier = ref.read(
      lessonPathUnitsProvider(widget.levelName).notifier,
    );
    final currentIndex = notifier.currentLessonIndex;

    if (currentIndex != -1) {
      _hasScrolledToCurrent = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_scrollController.hasClients) {
          return;
        }

        final isMobile = context.isMobile;
        final nodeVerticalSpacing = isMobile ? 120.h : 180.0;
        final nodeRowHeight = 96.r;
        final listTopPadding = 60.h;
        final bannerAreaHeight = 112.h; // 48.h height + 32.h * 2 padding

        var nodeY = listTopPadding + (nodeRowHeight / 2);
        for (var i = 0; i < currentIndex; i++) {
          if (widget.units[i].unitNumber % 12 == 0) {
            nodeY += nodeRowHeight + bannerAreaHeight;
          } else {
            nodeY += nodeVerticalSpacing;
          }
        }

        // Get the viewport height (the Expanded area)
        final viewportHeight = _scrollController.position.viewportDimension;

        // Target offset to put the node in the upper part of the map
        // (about 1/4 down from the top edge of the map)
        final targetOffset = nodeY - (viewportHeight * 0.25);

        _scrollController.jumpTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        );
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final nodeVerticalSpacing = isMobile ? 120.h : 180.0;
    final notifier = ref.read(
      lessonPathUnitsProvider(widget.levelName).notifier,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final nodeRowHeight = 96.r;
        final bannerAreaHeight = 112.h;
        final listTopPadding = 60.h;

        // Correctly calculate Y positions for the trail accounting for banners
        final nodePositions = <Offset>[];
        var currentY = listTopPadding + (nodeRowHeight / 2);

        for (var i = 0; i < widget.units.length; i++) {
          nodePositions.add(Offset(
            (i.isEven ? 0.3 : 0.7) * width,
            currentY,
          ));

          if (widget.units[i].unitNumber % 12 == 0) {
            currentY += nodeRowHeight + bannerAreaHeight;
          } else {
            currentY += nodeVerticalSpacing;
          }
        }

        return ClipRect(
          child: Stack(
            children: [
              if (widget.units.isNotEmpty)
                IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _scrollController,
                    builder: (context, child) {
                      final offset = _scrollController.hasClients
                          ? _scrollController.offset
                          : 0.0;
                      return Transform.translate(
                        offset: Offset(0, -offset),
                        child: child,
                      );
                    },
                    child: LessonPathTrail(
                      nodePositions: nodePositions,
                      canvasSize: Size(
                        width,
                        currentY + 60.h,
                      ),
                    ),
                  ),
                ),
              PaginatedListView<LessonUnitData>(
                key: PageStorageKey('lesson_path_list_${widget.levelName}'),
                controller: _scrollController,
                items: widget.units,
                isLoading: widget.isLoading,
                isLoadingMore: widget.isLoadingMore,
                hasMore: widget.hasMore,
                onLoadMore: notifier.loadMore,
                onRefresh: notifier.refresh,
                initialError: widget.initialError,
                paginationError: widget.paginationError,
                onRetryInitial: notifier.loadInitial,
                onRetryPagination: notifier.loadMore,
                padding: EdgeInsets.symmetric(vertical: 60.h),
                itemBuilder: (context, item) {
                  final index = widget.units.indexOf(item);
                  return LessonsListViewItem(
                    unit: item,
                    index: index,
                    nodeVerticalSpacing: nodeVerticalSpacing,
                    isLast: index == widget.units.length - 1,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
