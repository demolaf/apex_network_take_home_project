abstract class Auth {
  /// Get current user email
  String? get email;

  /// Get current user token
  String? get token;

  /// Set current user email
  void setEmail({required String email});

  /// Set current user token
  void setToken({required String token});

  /// [Future]<[void]> login user.
  ///
  /// API Method: POST
  /// headers: none
  ///
  /// parameters: [String] email, [String] password
  Future<void> login({required String email, required String password});

  /// [Future]<[void]> signup user.
  ///
  /// API Method: POST
  /// headers: none
  ///
  /// parameters: [String] full name, [String] email, [String] password
  Future<void> signup(
      {required String fullName,
      required String email,
      required String password,
      String? countryCode});

  /// [Future]<[String]>? get email token.
  ///
  /// API Method: POST
  /// headers: none
  ///
  /// parameters: [String] email
  Future<String?> getEmailToken({
    required String email,
  });

  /// [Future]<[String]>? verify email token.
  ///
  /// API Method: POST
  /// headers: none
  ///
  /// parameters: [String] email, [String] token
  Future<String?> verifyEmailWithToken(
      {required String email, required String token});

  /// [Future]<[void]> sign out user.
  ///
  /// API Method: POST
  ///
  /// headers: {
  ///   'Authorization': 'Bearer token'
  /// }
  ///
  /// parameters: none
  Future<void> logout();

  /// Check if there's a token in the app database
  Future<bool> hasAuthToken();

  /// Check if there's a pin code in the app database
  Future<bool> hasPinCode();

  /// Check user pin code and compare to pin code stored in app database
  Future<bool> verifyPinBeforeLogin({required String currentPinCode});
}
