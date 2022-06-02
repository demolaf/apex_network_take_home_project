import '../environment_config.dart';

class ApiBase {
  /// scheme
  static const httpsScheme = 'https';

  /// api constants
  static const apiHost = EnvironmentConfig.isDebug
      ? 'smart-pay-mobile.herokuapp.com'
      : 'smart-pay-mobile.herokuapp.com';

  static const apiVersion = '/api/v1';

  /// Api request related options
  static const receiveTimeout = 5000;
  static const sendTimeout = 3000;
  static const connectTimeout = 5000;

  /// Base Uris
  static get baseUri =>
      Uri(scheme: httpsScheme, host: apiHost, path: '$apiVersion/');
  static Uri authBase(String? endpoint) => Uri(
      scheme: httpsScheme,
      host: apiHost,
      path: '$apiVersion/auth${endpoint ?? ''}');
  static Uri dashboardBase(String? endpoint) => Uri(
      scheme: httpsScheme,
      host: apiHost,
      path: '$apiVersion/dashboard${endpoint ?? ''}');

  /// Endpoints
  static get login => authBase('/login');
  static get register => authBase('/register');
  static get logout => authBase('/logout');
  static get verifyEmailToken => authBase('/email/verify');
  static get getEmailToken => authBase('/email');
}
