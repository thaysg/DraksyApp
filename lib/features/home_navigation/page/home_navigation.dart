import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../feed/presentation/pages/feed_page.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../lessons/presentation/pages/lessons_page.dart';
import '../../profile/presentation/pages/profile_page.dart';
import '../../shop/presentation/pages/shop_page.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/floating_button_widget.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class HomeNavigation extends ConsumerWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    final pages = <Widget>[
      const HomePage(),
      const FeedPage(),
      const LessonsPage(),
      const ShopPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomBarWidget(
        selectedIndex: selectedIndex,
        onTap: (index) {
          if (index < 2) {
            ref.read(navigationIndexProvider.notifier).state = index;
          } else {
            ref.read(navigationIndexProvider.notifier).state = index + 1;
          }
        },
      ),
      floatingActionButton: FloatingButtonWidget(
        onTap: () {
          ref.read(navigationIndexProvider.notifier).state = 2;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
