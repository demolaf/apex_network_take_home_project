import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../core/constants/api_base.dart';
import 'api.dart';
import 'failure.dart';

/// Api Service Provider
final apiProvider = Provider<Api>(
  (ref) {
    return ApiImpl();
  },
);

class ApiImpl implements Api {
  final _log = Logger(filter: DevelopmentFilter());
  late final Dio _http;

  ApiImpl() {
    initialize();
  }

  void initialize() {
    _http = Dio()
      ..options.baseUrl = ApiEndpoints.baseUri.toString()
      ..options.connectTimeout = ApiEndpoints.connectTimeout
      ..options.sendTimeout = ApiEndpoints.sendTimeout
      ..options.responseType = ResponseType.json
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

    if (kDebugMode) {
      _http.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true));
    }

    _http.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<Map<String, dynamic>> get(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? onReceiveProgress}) async {
    return await _performRequest(
      _http.get(
        uri.toString(),
        queryParameters: queryParameters,
        options: options ?? Options(headers: headers),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// Try/catch to wrap api calls
  Future _performRequest(Future<Response<dynamic>> apiCall) async {
    try {
      final response = await apiCall;
      _throwOnFail(response);
      return response.data;
    } on DioError catch (e) {
      _log.e(e.error);
      throw Failure(
        message: e.message,
        data: json.decode(e.response.toString()),
      );
    } catch (e) {
      _log.e(e);
      throw Failure(
        message: e.toString(),
      );
    }
  }

  void _throwOnFail(Response response) {
    if (!response.statusCode.toString().contains('20')) {
      final failure = Failure.fromHttpErrorMap(json.decode(response.data));
      throw failure;
    }
  }
}
