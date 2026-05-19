abstract class LocalDataBase {
  Future<void> write(String key, Object? value);
  Future<T?> read<T>(String key);
  Future<void> delete(String key);
  Future<bool> exists(String key);
  Future<void> clear();

  /// Reads all values from a specific box.
  Future<List<T>> readAll<T>(String boxName);

  /// Clears user-specific data from the cache.
  /// Removes cached user data while preserving app-level settings.
  Future<void> clearUserData();
}
