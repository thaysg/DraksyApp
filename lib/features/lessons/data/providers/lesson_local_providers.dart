import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/storage_providers.dart';
import '../datasources/lesson_local_data_source.dart';
import '../datasources/lesson_local_data_source_impl.dart';

part 'lesson_local_providers.g.dart';

/// Provides the [LessonLocalDataSource] backed by the local database.
@riverpod
LessonLocalDataSource lessonLocalDataSource(Ref ref) {
  final localDb = ref.watch(localDataBaseProvider);
  return LessonLocalDataSourceImpl(localDb);
}
