import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/widgets/section_header.dart';
import '../presentation/models/feed_view_data.dart';
import 'ranking_card.dart';

class WeeklyRankingSection extends StatelessWidget {
  const WeeklyRankingSection({required this.rankings, super.key});

  final List<FeedRankingData> rankings;

  @override
  Widget build(BuildContext context) {
    if (rankings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: context.l10n.weeklyRanking,
        ),
        16.heightBox,
        SizedBox(
          height: 150.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (rankings.any((r) => r.position == 2))
                Expanded(
                  child: RankingCard(
                    data: rankings.firstWhere((r) => r.position == 2),
                    height: 130.h,
                  ),
                )
              else
                const Spacer(),
              12.widthBox,
              if (rankings.any((r) => r.position == 1))
                Expanded(
                  child: RankingCard(
                    data: rankings.firstWhere((r) => r.position == 1),
                    height: 150.h,
                  ),
                )
              else
                const Spacer(),
              12.widthBox,
              if (rankings.any((r) => r.position == 3))
                Expanded(
                  child: RankingCard(
                    data: rankings.firstWhere((r) => r.position == 3),
                    height: 130.h,
                  ),
                )
              else
                const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
