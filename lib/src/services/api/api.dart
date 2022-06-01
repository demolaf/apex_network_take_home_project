import 'package:dio/dio.dart';

abstract class Api {
  /// For making http get requests
  Future<Map<String, dynamic>> get(
    Uri uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onReceiveProgress,
  });

  /// For making http post requests
  Future<dynamic> post(
    Uri uri, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });
}
