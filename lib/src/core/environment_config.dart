// Environment Config
class EnvironmentConfig {
  static const String production = 'production';
  static const String development = 'development';
  static const env = String.fromEnvironment('env', defaultValue: development);
  static const bool isDebug = env == development;
}
