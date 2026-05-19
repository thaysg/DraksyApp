import 'package:flutter/material.dart';

import '../../../../../core/responsive/app_responsive.dart';
import '../../../../../core/utils/pagination/paginated_state.dart';
import '../../../domain/entities/lesson_unit_data.dart';
import '../../models/lessons_path_view_data.dart';
import '../../widgets/lesson_category_progress_card.dart';
import '../../widgets/lesson_path_app_bar.dart';
import '../../widgets/lesson_path_map.dart';

class LessonPathTabletView extends StatelessWidget {
  const LessonPathTabletView({
    required this.data,
    required this.unitsState,
    super.key,
  });

  final LessonsPathViewData data;
  final PaginatedState<LessonUnitData> unitsState;

  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.maxContentWidth(context),
          ),
          child: Column(
            children: [
              LessonPathAppBar(title: data.categoryTitle),
              LessonCategoryProgressCard(
                progress: data.progress,
                currentUnits: data.currentUnits,
                totalUnits: data.totalUnits,
                nextUnitNumber: data.nextUnitNumber,
              ),
              Expanded(
                child: LessonPathMap(
                  units: unitsState.items,
                  levelName: data.levelName,
                  isLoading: unitsState.isLoading,
                  isLoadingMore: unitsState.isLoadingMore,
                  hasMore: unitsState.hasMore,
                  initialError: unitsState.initialError,
                  paginationError: unitsState.paginationError,
                ),
              ),
            ],
          ),
        ),
      );
}
