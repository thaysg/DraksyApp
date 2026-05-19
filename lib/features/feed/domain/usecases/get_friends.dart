import 'package:strawti_utils/strawti_utils.dart';

import '../../data/models/feed_friend_model.dart';
import '../repositories/feed_repository.dart';

/// Use case to fetch friends list.
class GetFriends {
  const GetFriends(this._repository);

  final FeedRepository _repository;

  Future<StrautilsResponse<List<FeedFriendModel>>> call() async =>
      _repository.getFriends();
}
