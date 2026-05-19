# Rules — `lib/features/lessons/`

Lessons feature. Full Clean Architecture. Contains three sub-pages: lessons list, lesson path, and lesson detail.

---

## Structure

```
lessons/
  presentation/
    pages/
      lessons_page.dart
      lessons_path_page.dart
      lesson_detail_page.dart
    views/
      lessons_mobile_view.dart
      lessons_tablet_view.dart
      lessons_desktop_view.dart
      lesson_path_mobile_view.dart
      lesson_path_tablet_view.dart
      lesson_path_desktop_view.dart
      lesson_detail_mobile_view.dart
      lesson_detail_tablet_view.dart
      lesson_detail_desktop_view.dart
    providers/
      lessons_provider.dart / .g.dart
      lesson_path_provider.dart / .g.dart
      lesson_detail_provider.dart / .g.dart
    models/
      lessons_view_data.dart
      lessons_path_view_data.dart
      lesson_detail_view_data.dart
    widgets/
      lesson_category_card.dart
      lesson_category_progress_card.dart
      lesson_filter_chip.dart
      lessons_header.dart
      lesson_path_map.dart
      lesson_path_trail.dart
      lesson_path_trail_segment.dart
      lesson_path_trail_painter.dart
      lesson_path_app_bar.dart
      lesson_path_current_node.dart
      lesson_path_node.dart
      lesson_path_static_node.dart
      lesson_section_cleared_banner.dart
      lesson_options_grid.dart
      lesson_detail views: card_meaning.dart, grammar_tip.dart, check_button.dart,
                           exercice_divider.dart, bubble_tail_painter.dart,
                           app_bar_lessons_detail.dart
  data/
    datasources/
      lesson_local_data_source.dart       # Abstract interface
      lesson_local_data_source_impl.dart  # Hive implementation
    models/
      lesson_progress_model.dart          # @HiveType(typeId: 0)
    providers/
      lesson_local_providers.dart / .g.dart
  domain/
    entities/
      lesson_unit_data.dart
      lesson_node_state.dart              # Enum
```

---

## Page Rules

- Each page (`LessonsPage`, `LessonsPathPage`, `LessonDetailPage`) is a `ConsumerWidget`.
- Handles `AsyncValue.when(data/loading/error)`.
- Dispatches to mobile/tablet/desktop views via `ResponsiveLayoutBuilder`.
- `ref.watch` lives **only** in pages.

---

## View Rules

- Always `StatelessWidget`.
- Receive the appropriate `*ViewData` as a required parameter.
- No `ref.watch` or provider calls.

---

## Widget Rules

- `1 file = 1 public widget class`.
- `lesson_path_current_node.dart` — uses `StatefulWidget` + `_LessonPathCurrentNodeState` in one file. **This is valid** (one public widget + its private State).
- No `_build*` methods.
- All colors → `AppColors`.
- All text styles → `AppTextStyles`.
- All sizes → `.sp` / `.r` / `.w` / `.h`.

---

## Hive / Data Layer Rules

### `lesson_progress_model.dart`
- `@HiveType(typeId: 0)` — TypeId **0 is reserved** for this model. Never reuse.
- Extends `HiveObject`.
- Box key: `'${unitId}_$nodeId'`.

### `LessonLocalDataSource` (interface)
- Lives in `data/datasources/` — no Hive import, pure contract.
- Methods: `getProgress`, `saveProgress`, `getAllProgress`, `clearAll`.

### `LessonLocalDataSourceImpl`
- Only place that touches `Box<dynamic>`.
- Injected via `hiveBoxProvider(AppBoxNames.lessonProgress)`.

### Provider
```dart
@riverpod
LessonLocalDataSource lessonLocalDataSource(Ref ref) {
  final box = ref.watch(hiveBoxProvider(AppBoxNames.lessonProgress));
  return LessonLocalDataSourceImpl(box);
}
```

### FORBIDDEN Anti-Patterns
```dart
// ❌ Raw string box name
Hive.box('lesson_progress_box')

// ❌ Opening box outside main()
await Hive.openBox(...)

// ❌ Accessing Hive.box() in a widget
final box = Hive.box<dynamic>('lesson_progress_box')

// ❌ Reusing TypeId 0
@HiveType(typeId: 0)
class AnotherModel ...  // CONFLICT
```

---

## Domain Layer Rules

- `LessonUnitData` and `LessonNodeState` — pure Dart, zero Flutter imports.
- No business logic in widgets or views.

---

## Navigation Rules

- Lessons list → path: `context.pushNamed(AppRoutes.lessonPath, ...)`.
- Path → detail: `context.pushNamed(AppRoutes.lessonDetail, ...)`.
- **FORBIDDEN**: `Navigator.push`.
