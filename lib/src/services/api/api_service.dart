import 'dart:convert';

import 'package:apex_network_take_home_project/src/core/constants/hive_storage_keys.dart';
import 'package:apex_network_take_home_project/src/core/constants/hive_type_id_keys.dart';
import 'package:apex_network_take_home_project/src/services/api/interceptors/auth_api_interceptor.dart';
import 'package:apex_network_take_home_project/src/services/local_storage/local_storage.dart';
import 'package:apex_network_take_home_project/src/services/local_storage/local_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../core/constants/api_base.dart';
import '../../model/auth/auth_user.dart';
import 'api.dart';
import 'failure.dart';

/// Api Service Provider
final apiProvider = Provider<Api>(
  (ref) => ApiService(
    ref.watch(localStorageProvider.future),
  ),
);

class ApiService implements Api {
  ApiService(this._localStorage) {
    initialize();
  }

  final _log = Logger(filter: DevelopmentFilter());
  final Future<LocalStorage> _localStorage;

  late final Dio _http;

  void initialize() {
    _http = Dio()
      ..options.baseUrl = ApiBase.baseUri.toString()
      ..options.connectTimeout = ApiBase.connectTimeout
      ..options.sendTimeout = ApiBase.sendTimeout
      ..options.responseType = ResponseType.json
      ..options.receiveTimeout = ApiBase.receiveTimeout
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

    _http.interceptors.add(AuthApiInterceptor(_localStorage));
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

  @override
  Future post(Uri uri,
      {required Map<String, dynamic> body,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      Map<String, dynamic>? headers,
      Options? options,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    return await _performRequest(
      _http.post(
        uri.toString(),
        queryParameters: queryParameters,
        options: options ?? Options(headers: headers),
        cancelToken: cancelToken,
        data: body,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
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
      _log.e('Check here for errors api ${e.response?.data}');
      throw Failure(
          message: Failure.fromJson(e.response?.data ?? '' ?? []).message,
          data: Failure.fromJson(e.response?.data ?? [] ?? {}).data,
          errors: Failure.fromJson(e.response?.data ?? {} ?? []).errors);
    } catch (e) {
      _log.e(e);
      throw Failure(
        message: e.toString(),
      );
    }
  }

  void _throwOnFail(Response response) {
    if (!response.statusCode.toString().contains('20')) {
      final failure = Failure.fromJson(json.decode(response.data));
      throw failure;
    }
  }
}
