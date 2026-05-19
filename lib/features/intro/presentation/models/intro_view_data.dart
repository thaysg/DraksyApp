import 'package:equatable/equatable.dart';

/// UI-ready data for the Intro screen.
class IntroViewData extends Equatable {
  const IntroViewData({
    required this.currentIndex,
    required this.isFirstPage,
    required this.isLastPage,
  });

  final int currentIndex;
  final bool isFirstPage;
  final bool isLastPage;

  @override
  List<Object?> get props => [currentIndex, isFirstPage, isLastPage];
}
