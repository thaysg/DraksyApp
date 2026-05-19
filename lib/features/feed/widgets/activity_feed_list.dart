import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../presentation/models/feed_view_data.dart';
import 'activity_item_card.dart';

class ActivityFeedList extends StatelessWidget {
  const ActivityFeedList({required this.activities, super.key});

  final List<FeedActivityData> activities;

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        separatorBuilder: (context, index) => 12.heightBox,
        itemBuilder: (context, index) => ActivityItemCard(
          data: activities[index],
        ),
      );
}
