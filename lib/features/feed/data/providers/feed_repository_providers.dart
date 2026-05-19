import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/feed_repository.dart';
import '../repositories/feed_repository_impl.dart';
import 'feed_remote_providers.dart';

part 'feed_repository_providers.g.dart';

/// Provides the [FeedRepository] implementation.
@riverpod
FeedRepository feedRepository(Ref ref) {
  final remote = ref.watch(feedRemoteDataSourceProvider);
  return FeedRepositoryImpl(remote: remote);
}
