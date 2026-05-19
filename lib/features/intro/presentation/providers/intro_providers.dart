import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../splash/presentation/providers/splash_provider.dart';
import '../models/intro_view_data.dart';

part 'intro_providers.g.dart';

@riverpod
IntroViewData introView(Ref ref) {
  final currentIndex = ref.watch(introIndexProvider);
  return IntroViewData(
    currentIndex: currentIndex,
    isFirstPage: currentIndex == 0,
    isLastPage: currentIndex == 3,
  );
}

@riverpod
class IntroIndex extends _$IntroIndex {
  @override
  int build() => 0;

  void next(PageController controller) {
    if (state < 3) {
      state++;
      controller.animateToPage(
        state,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previous(PageController controller) {
    if (state > 0) {
      state--;
      controller.animateToPage(
        state,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> completeOnboarding() async {
    await ref.read(splashProvider.notifier).completeOnboarding();
  }

  int get index => state;

  set index(int value) {
    state = value;
  }
}

@riverpod
PageController pageController(Ref ref) {
  final controller = PageController();
  ref.onDispose(controller.dispose);
  return controller;
}
