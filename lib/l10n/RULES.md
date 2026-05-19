# Rules — `lib/l10n/`

Localization files (ARB) and generated Dart classes.

---

## Files

| File | Purpose |
|---|---|
| `app_en.arb` | English strings — source of truth |
| `app_pt.arb` | Portuguese strings |
| `app_localizations.dart` | Generated base class — do **not** edit manually |
| `app_localizations_en.dart` | Generated EN — do **not** edit manually |
| `app_localizations_pt.dart` | Generated PT — do **not** edit manually |

---

## Rules

### FORBIDDEN — hardcoded user-visible strings:
```dart
// ❌ FORBIDDEN anywhere in the codebase
Text('Daily Challenge')
Text('Continue Learning')
title: 'Settings'
```

### REQUIRED — use context.l10n:
```dart
// ✅ CORRECT
Text(context.l10n.dailyChallenge)
Text(context.l10n.continueLearning)
title: context.l10n.settings
context.l10n.unitLesson(3, 2)   // parameterized
```

### Adding a new string
1. Add the key + English value to `app_en.arb`.
2. Add the key + Portuguese translation to `app_pt.arb`.
3. Run `flutter gen-l10n` (or let the IDE do it on save) to regenerate the Dart files.
4. Use `context.l10n.yourNewKey` in the widget.

**Never** add a string to only one ARB file — both must be updated together.

### Parameterized strings
```arb
// app_en.arb
"unitLesson": "Unit {unit}, Lesson {lesson}",
"@unitLesson": {
  "placeholders": {
    "unit": { "type": "int" },
    "lesson": { "type": "int" }
  }
}
```

```dart
// Usage
context.l10n.unitLesson(3, 2)  // → "Unit 3, Lesson 2"
```
