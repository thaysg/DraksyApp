import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/pagination/paginated_notifier.dart';
import '../../../../core/utils/pagination/paginated_state.dart';
import '../../data/models/lesson_progress_model.dart';
import '../../domain/providers/lesson_usecase_providers.dart';

part 'user_progress_provider.g.dart';

@riverpod
class UserProgressNotifier extends _$UserProgressNotifier
    with PaginatedNotifierMixin<LessonProgressModel> {
  @override
  PaginatedState<LessonProgressModel> build() {
    Future.microtask(loadInitial);
    return PaginatedState<LessonProgressModel>.initial()
        .copyWith(isLoading: true);
  }

  @override
  PageFetcher<LessonProgressModel> get fetchPage => (request) async {
        final getUserProgress = ref.read(getUserProgressProvider);
        final response = await getUserProgress(request);

        if (response.error) {
          throw Exception(response.message);
        }

        return response.data!;
      };
}
