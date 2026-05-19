/// Logic to resolve dragon asset paths based on pose and color.
class DragonAssets {
  DragonAssets._();

  static const Map<String, String> _poseMap = {
    'dragon_greeting': 'Waving',
    'dragon_happy': 'Happy',
    'dragon_thinking': 'Thinking',
    'dragon_neutral': 'Sitting',
    'dragon_celebrating': 'Celebrating',
    'dragon_sad': 'Sad',
  };

  /// List of all available dragon colors.
  static const List<String> colors = [
    'Black',
    'Blue',
    'Gold',
    'Green',
    'Orange',
    'Pink',
    'Purple',
    'Red',
    'Teal',
    'White',
  ];

  /// Map of available poses for each dragon color.
  /// Used to fallback when a specific pose-color combination is missing.
  static const Map<String, List<String>> _colorPoses = {
    'Black': ['Happy', 'Waving'],
    'Blue': ['Flying', 'Shy', 'Sitting', 'Waving'],
    'Gold': ['Playful'],
    'Green': ['ArmsCrossed', 'Jumping', 'LookingSide', 'Waving', 'Winking'],
    'Orange': ['ArmsCrossed', 'Jumping', 'Waving'],
    'Pink': ['Excited'],
    'Purple': ['ArmsCrossed', 'Flying', 'Laughing'],
    'Red': ['Waving'],
    'Teal': ['Surprised', 'Tinking', 'Waving'],
    'White': ['Cute', 'Happy'],
  };

  /// Resolves the asset path for a dragon.
  ///
  /// [imageKey]  — comes from the node content (e.g. 'dragon_greeting')
  /// [color]     — user's selected dragon color
  static String resolve(String imageKey, String color) {
    var pose = _poseMap[imageKey] ?? 'Sitting';

    final available = _colorPoses[color] ?? _colorPoses['Blue']!;

    if (!available.contains(pose)) {
      // Heuristic fallback for common missing poses
      if (pose == 'Sitting') {
        if (available.contains('Happy')) {
          pose = 'Happy';
        } else if (available.contains('Waving')) {
          pose = 'Waving';
        } else if (available.contains('Playful')) {
          pose = 'Playful';
        } else if (available.contains('Cute')) {
          pose = 'Cute';
        }
      } else if (pose == 'Thinking' && available.contains('Tinking')) {
        pose = 'Tinking';
      } else if (pose == 'Happy' && available.contains('Excited')) {
        pose = 'Excited';
      } else if (pose == 'Celebrating' && available.contains('Happy')) {
        pose = 'Happy';
      }

      // Final fallback if still not found in available list
      if (!available.contains(pose)) {
        pose = available.first;
      }
    }

    return 'assets/dragons/$color$pose.png';
  }
}
