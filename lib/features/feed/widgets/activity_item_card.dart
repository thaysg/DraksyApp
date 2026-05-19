import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../presentation/models/feed_view_data.dart';
import 'active_item_body.dart';
import 'activity_badge.dart';
import 'user_avatar_status.dart';

class ActivityItemCard extends StatelessWidget {
  const ActivityItemCard({required this.data, super.key});

  final FeedActivityData data;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: EdgeInsets.all(16.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatarStatus(data: data),
            10.widthBox,
            Expanded(
              child: ActiveItemBody(
                  data: data, activeTitle: _getActivityTitle(context)),
            ),
            8.widthBox,
            ActivityBadge(type: data.type, value: data.value),
          ],
        ),
      );

  String _getActivityTitle(BuildContext context) => switch (data.type) {
        FeedActivityType.lesson =>
          context.l10n.activityCompletedLesson(data.userName),
        FeedActivityType.level =>
          context.l10n.activityReachedLevel(data.userName),
        FeedActivityType.streak =>
          context.l10n.activityMaintainedStreak(data.userName),
        FeedActivityType.achievement =>
          context.l10n.activityWonAchievement(data.userName),
      };
}
