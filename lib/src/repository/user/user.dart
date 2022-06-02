abstract class User {
  bool get isRegisterFlow;

  /// Save user pin code to app database and persist
  Future<void> setUserPinCode({required String pinCode});

  Future<String?> getName();

  void setIsRegisterFlow(bool value);
}
