# Rules — `lib/core/errors/`

Domain-level error types. Used by repositories and use cases.

---

## Files

| File | Contents |
|---|---|
| `exceptions.dart` | `Exception` subclasses (thrown by data sources) |
| `failures.dart` | `Failure` sealed/abstract classes (returned by repositories) |

---

## Rules

### Exceptions (`exceptions.dart`)
- Thrown by **data sources** (`datasources/`) when an operation fails.
- Examples: `AuthException`, `NetworkException`, `CacheException`.
- Never throw raw `Exception()` — always use a typed exception.
- **Messages must be in English.**

### Failures (`failures.dart`)
- Returned by **repositories** as a result type (not thrown).
- Used with `StrautilsResponse` / `tryThis` pattern.
- Examples: `AuthFailure`, `NetworkFailure`, `CacheFailure`.
- **Messages must be in English.**

### Error Handling Pattern (Repositories)
```dart
// ✅ CORRECT — using tryThis from strawti_utils
FStrautilsResponse<User> signInWithGoogle() async => tryThis(
  () async {
    final userModel = await _remoteDataSource.signInWithGoogle();
    return StrautilsResponse.success(userModel);
  },
  onCatch: (error) {
    if (error is AppException) {
      return StrautilsResponse.error(error.message, error: error);
    }
    return StrautilsResponse.error(error.toString(), error: error);
  },
  tryAgain: signInWithGoogle,
  action: 'sign in with Google',
);
```

### UI Layer Pattern
Error messages displayed to the user use the `Failure.message` property directly.
```dart
// ✅ CORRECT
final failure = response.error as Failure;
showSnackBar(failure.message);
```

### Never:
```dart
// ❌ Catch-all without typed handling
try { ... } catch (e) { throw Exception(e.toString()); }

// ❌ Throwing Failures (Failures are returned, not thrown)
throw AuthFailure('message');

// ❌ Using raw strings for error messages
throw Exception('something went wrong');  // use typed exceptions

// ❌ Using Portuguese in error messages or comments
// All error-related strings and code documentation MUST be in English.
```

### Adding New Errors
- New exception type → `exceptions.dart`.
- New failure type → `failures.dart`.
- Keep them paired: one `XyzException` → one `XyzFailure`.
