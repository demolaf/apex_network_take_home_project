import 'package:apex_network_take_home_project/src/core/constants/api_base.dart';
import 'package:apex_network_take_home_project/src/core/constants/hive_storage_keys.dart';
import 'package:apex_network_take_home_project/src/core/constants/hive_type_id_keys.dart';
import 'package:apex_network_take_home_project/src/model/auth/auth_user.dart';
import 'package:apex_network_take_home_project/src/model/auth/email_token_verify.dart';
import 'package:apex_network_take_home_project/src/model/auth/verify_email.dart';
import 'package:apex_network_take_home_project/src/services/api/api.dart';
import 'package:apex_network_take_home_project/src/services/api/api_service.dart';
import 'package:apex_network_take_home_project/src/services/local_storage/local_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../services/local_storage/local_storage.dart';
import 'auth.dart';

/// AuthImpl Repository Provider
final authRepository = Provider<Auth>(
  (ref) => AuthImpl(
    ref.read(apiProvider),
    ref.watch(localStorageProvider.future),
  ),
);

class AuthImpl implements Auth {
  AuthImpl(this._api, this._localStorage);

  final Api _api;
  final _log = Logger(filter: DevelopmentFilter());
  final Future<LocalStorage> _localStorage;

  String? _email;

  @override
  String? get email => _email;

  String? _token;

  @override
  String? get token => _token;

  @override
  Future<void> login({required String email, required String password}) async {
    final response = await _api.post(
      ApiBase.login,
      body: {
        'email': email,
        'password': password,
        'device_name': 'mobile',
      },
    );

    AuthData? authData = AuthResponse.fromJson(response).data;
    await _localStorage.then(
      (storage) async => await storage.put(HiveStorageKeys.authDataBox,
          key: HiveTypeIdKeys.authDataTypeIdKey, value: authData),
    );
  }

  @override
  Future<void> signup(
      {required String fullName,
      required String email,
      required String password,
      String? countryCode}) async {
    final response = await _api.post(
      ApiBase.register,
      body: {
        'full_name': fullName,
        'email': email,
        'country': countryCode,
        'password': password,
        'device_name': 'mobile',
      },
    );

    AuthData? authData = AuthResponse.fromJson(response).data;
    await _localStorage.then(
      (storage) async => await storage.put(HiveStorageKeys.authDataBox,
          key: HiveTypeIdKeys.authDataTypeIdKey, value: authData),
    );
  }

  @override
  Future<String?> getEmailToken({required String email}) async {
    final response = await _api.post(
      ApiBase.getEmailToken,
      body: {
        'email': email,
      },
    );

    return EmailTokenVerifyResponse.fromJson(response).data?.token;
  }

  @override
  Future<String?> verifyEmailWithToken(
      {required String email, required String token}) async {
    final response = await _api.post(
      ApiBase.verifyEmailToken,
      body: {
        'email': email,
        'token': token,
      },
    );

    return VerifyEmailResponse.fromJson(response).data?.email;
  }

  @override
  void setEmail({required String email}) {
    _email = email;
  }

  @override
  void setToken({required String token}) {
    _token = token;
  }

  @override
  Future<void> logout() async {
    _api.post(ApiBase.logout, body: {});
    await _localStorage.then(
      (storage) async => await storage.delete(HiveStorageKeys.authDataBox,
          key: HiveTypeIdKeys.authDataTypeIdKey),
    );
  }

  @override
  Future<bool> hasAuthToken() async {
    try {
      // get existing auth from database
      final AuthData auth = await _localStorage.then<AuthData>(
          (storage) async => await storage.get(HiveStorageKeys.authDataBox,
              key: HiveTypeIdKeys.authDataTypeIdKey));
      _log.i('Name ${auth.user?.fullName} Token length ${auth.token?.length}');
      if (auth.token != null) {
        return true;
      }
    } catch (e) {
      _log.e('Token does not exist');
    }
    return false;
  }

  @override
  Future<bool> hasPinCode() async {
    try {
      // get existing auth from database
      final AuthData auth = await _localStorage.then<AuthData>(
          (storage) async => await storage.get(HiveStorageKeys.authDataBox,
              key: HiveTypeIdKeys.authDataTypeIdKey));
      _log.i(
          'Name ${auth.user?.fullName} Has pin code ${auth.user?.pinCode?.isNotEmpty}');
      if (auth.user?.pinCode != null) {
        return true;
      }
    } catch (e) {
      _log.e('Token does not exist');
    }
    return false;
  }

  @override
  Future<bool> verifyPinBeforeLogin({required String currentPinCode}) async {
    AuthData? authData = await _localStorage.then<AuthData?>((storage) async =>
        await storage.get(HiveStorageKeys.authDataBox,
            key: HiveTypeIdKeys.authDataTypeIdKey));
    _log.d(
        'Current pin $currentPinCode, Saved pin code ${authData?.user?.pinCode}');
    if (currentPinCode == authData?.user?.pinCode) {
      return true;
    } else {
      return false;
    }
  }
}
