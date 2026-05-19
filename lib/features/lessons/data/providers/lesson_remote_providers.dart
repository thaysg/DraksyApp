import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../datasources/lesson_remote_data_source.dart';
import '../datasources/lesson_remote_data_source_impl.dart';

part 'lesson_remote_providers.g.dart';

/// Provides the [LessonRemoteDataSource] backed by Supabase.
@riverpod
LessonRemoteDataSource lessonRemoteDataSource(Ref ref) =>
    const LessonRemoteDataSourceImpl();
