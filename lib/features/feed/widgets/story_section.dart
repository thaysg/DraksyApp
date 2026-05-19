import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/spacing.dart';
import '../presentation/models/feed_view_data.dart';
import 'invite_friends_card.dart';
import 'story_item.dart';

class StorySection extends StatelessWidget {
  const StorySection({required this.stories, super.key});

  final List<FeedStoryData> stories;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 120.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: stories.length + 1,
          separatorBuilder: (context, index) => 16.widthBox,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const InviteFriendsCard();
            }
            return StoryItem(data: stories[index - 1]);
          },
        ),
      );
}
