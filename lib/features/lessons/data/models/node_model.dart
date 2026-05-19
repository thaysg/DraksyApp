import 'package:equatable/equatable.dart';
import 'node_content_model.dart';

/// Represents a node within a lesson.
final class NodeModel extends Equatable {
  const NodeModel({
    required this.id,
    required this.lessonId,
    required this.orderIndex,
    required this.type,
    required this.content,
  });

  factory NodeModel.fromJson(Map<String, dynamic> json) => NodeModel(
        id: json['id'] as String,
        lessonId: json['lesson_id'] as String,
        orderIndex: json['order_index'] as int,
        type: json['type'] as String,
        content: NodeContentModel.fromJson(
          json['content'] as Map<String, dynamic>,
        ),
      );

  final String id;
  final String lessonId;
  final int orderIndex;
  final String type; // 'explanation' | 'question'
  final NodeContentModel content;

  Map<String, dynamic> toJson() => {
        'id': id,
        'lesson_id': lessonId,
        'order_index': orderIndex,
        'type': type,
        'content': content.toJson(),
      };

  @override
  List<Object?> get props => [id, lessonId, orderIndex, type, content];
}
