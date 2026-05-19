import 'package:equatable/equatable.dart';

class LevelModel extends Equatable {
  const LevelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.orderIndex,
    required this.lessonCount,
    required this.languageTarget,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) => LevelModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String? ?? '',
        orderIndex: json['order_index'] as int,
        lessonCount: json['lesson_count'] as int,
        languageTarget: json['language_target'] as String,
      );

  final String id;
  final String name;
  final String description;
  final int orderIndex;
  final int lessonCount;
  final String languageTarget;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'order_index': orderIndex,
        'lesson_count': lessonCount,
        'language_target': languageTarget,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        orderIndex,
        lessonCount,
        languageTarget,
      ];
}
