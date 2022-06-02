abstract class User {
  /// Check if user in registration flow
  bool get isRegisterFlow;

  /// Save user pin code to app database and persist
  Future<void> setUserPinCode({required String pinCode});

  /// Get currently active user name
  Future<String?> getName();

  /// Set if user in registration flow
  void setIsRegisterFlow(bool value);
}
