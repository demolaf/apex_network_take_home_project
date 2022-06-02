abstract class Dashboard {
  /// [Future]<[String]>? fetch dashboard secret.
  ///
  /// API Method: GET
  ///
  /// headers: {
  ///   'Authorization': 'Bearer token'
  /// }
  ///
  /// parameters: none
  Future<String?> getDashboardSecret();
}
