import 'package:equatable/equatable.dart';

class FeedWeeklyChallengeModel extends Equatable {
  const FeedWeeklyChallengeModel({
    required this.title,
    required this.description,
    required this.completedLessons,
    required this.totalLessons,
    required this.remainingTime,
  });

  factory FeedWeeklyChallengeModel.fromJson(Map<String, dynamic> json) =>
      FeedWeeklyChallengeModel(
        title: json['title'] as String? ?? 'Weekly Challenge',
        description: json['description'] as String? ?? '',
        completedLessons: json['completed_lessons'] as int? ?? 0,
        totalLessons: json['total_lessons'] as int? ?? 1,
        remainingTime: json['remaining_time'] as String? ?? '0h',
      );

  final String title;
  final String description;
  final int completedLessons;
  final int totalLessons;
  final String remainingTime;

  @override
  List<Object?> get props => [
        title,
        description,
        completedLessons,
        totalLessons,
        remainingTime,
      ];
}
