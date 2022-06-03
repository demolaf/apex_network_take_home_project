import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../core/constants/hive_storage_keys.dart';
import '../../../core/constants/hive_type_id_keys.dart';
import '../../../model/auth/auth_user.dart';
import '../../local_storage/local_storage.dart';

class AuthApiInterceptor implements Interceptor {
  AuthApiInterceptor(this._localStorage);

  final Future<LocalStorage> _localStorage;
  final _log = Logger(filter: DevelopmentFilter());

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    AuthData? auth;
    try {
      auth = await _localStorage.then((storage) async => await storage.get(
          HiveStorageKeys.authDataBox,
          key: HiveTypeIdKeys.authDataTypeIdKey));
      _log.i("Auth user data exists ${auth?.token?.length}");
    } catch (e) {
      _log.e("No auth user data");
    }

    if (!options.path.contains('/auth') &&
        !options.path.contains('/auth/logout')) {
      options.headers['Authorization'] = 'Bearer ${auth?.token}';
    }
    return handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
