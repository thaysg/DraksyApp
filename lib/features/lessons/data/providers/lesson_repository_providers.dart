import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/lesson_repository.dart';
import '../repositories/lesson_repository_impl.dart';
import 'lesson_local_providers.dart';
import 'lesson_remote_providers.dart';

part 'lesson_repository_providers.g.dart';

/// Provides the [LessonRepository] implementation.
@riverpod
LessonRepository lessonRepository(Ref ref) {
  final local = ref.watch(lessonLocalDataSourceProvider);
  final remote = ref.watch(lessonRemoteDataSourceProvider);
  return LessonRepositoryImpl(local: local, remote: remote);
}
