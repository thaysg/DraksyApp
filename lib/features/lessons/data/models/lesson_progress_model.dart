import 'package:hive_ce/hive.dart';

part 'lesson_progress_model.g.dart';

/// Hive-persisted model for lesson progress.
///
/// After adding or changing fields, regenerate the adapter:
/// ```sh
/// dart run build_runner build --delete-conflicting-outputs
/// ```
///
/// Then register the adapter in `main.dart` → `_registerHiveAdapters()`:
/// ```dart
/// Hive.registerAdapter(LessonProgressModelAdapter());
/// ```
@HiveType(typeId: 0)
class LessonProgressModel extends HiveObject {
  LessonProgressModel({
    required this.unitId,
    required this.nodeId,
    required this.isCompleted,
    required this.xpEarned,
    required this.completedAt,
    this.accuracy = 0.0,
  });

  /// Creates a model from a map (Supabase response).
  factory LessonProgressModel.readFromMap(Map<String, dynamic> map) =>
      LessonProgressModel(
        unitId: map['unit_id'] as String? ?? '',
        nodeId: map['node_id'] as String? ?? '',
        isCompleted: map['is_completed'] as bool? ?? false,
        xpEarned: (map['xp_earned'] as num?)?.toInt() ?? 0,
        completedAt: map['completed_at'] as String?,
        accuracy: (map['accuracy'] as num?)?.toDouble() ?? 0.0,
      );

  /// Unique identifier of the unit this node belongs to.
  @HiveField(0)
  String unitId;

  /// Unique identifier of the lesson node.
  @HiveField(1)
  String nodeId;

  /// Whether the user has completed this lesson node.
  @HiveField(2)
  bool isCompleted;

  /// XP earned upon completion.
  @HiveField(3)
  int xpEarned;

  /// ISO-8601 timestamp of when the node was completed. Null if not yet done.
  @HiveField(4)
  String? completedAt;

  /// Accuracy achieved in the lesson (0.0 to 1.0).
  @HiveField(5)
  double accuracy;

  /// Composite key used to store/retrieve this record in the box.
  String get boxKey => '${unitId}_$nodeId';
}
