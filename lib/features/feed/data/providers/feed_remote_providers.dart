import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../datasources/feed_remote_data_source.dart';
import '../datasources/feed_remote_data_source_impl.dart';

part 'feed_remote_providers.g.dart';

/// Provides the [FeedRemoteDataSource] backed by Supabase.
@riverpod
FeedRemoteDataSource feedRemoteDataSource(Ref ref) =>
    const FeedRemoteDataSourceImpl();
