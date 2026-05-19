import 'package:equatable/equatable.dart';

class UnitModel extends Equatable {
  const UnitModel({
    required this.id,
    required this.orderIndex,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.languageTarget,
    required this.lessonId, // ← novo
  }); // ← novo

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json['id'] as String,
        orderIndex: json['order_index'] as int,
        title: json['title'] as String,
        description: json['description'] as String? ?? '',
        difficulty: json['difficulty'] as String,
        languageTarget: json['language_target'] as String,
        lessonId:
            (json['lessons'] as List?)?.first?['id'] as String? ?? '', // ← novo
      );

  final String id;
  final int orderIndex;
  final String title;
  final String description;
  final String difficulty;
  final String languageTarget;
  final String lessonId;

  @override
  List<Object?> get props => [
        id,
        orderIndex,
        title,
        description,
        difficulty,
        languageTarget,
        lessonId
      ];
}
