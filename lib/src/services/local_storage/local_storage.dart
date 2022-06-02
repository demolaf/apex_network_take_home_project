abstract class LocalStorage {
  /// Create
  Future<int?> add(String boxIdentifier, {required dynamic value});

  /// Read
  Future<dynamic> get(String boxIdentifier, {required dynamic key});

  /// Update
  Future<void> put(String boxIdentifier,
      {required dynamic key, required dynamic value});

  /// Delete
  Future<void> delete(String boxIdentifier, {required dynamic key});
}
