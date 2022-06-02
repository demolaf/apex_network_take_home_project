import 'package:apex_network_take_home_project/src/core/constants/hive_storage_keys.dart';
import 'package:apex_network_take_home_project/src/core/constants/hive_type_id_keys.dart';
import 'package:apex_network_take_home_project/src/repository/user/user.dart';
import 'package:apex_network_take_home_project/src/services/local_storage/local_storage.dart';
import 'package:apex_network_take_home_project/src/services/local_storage/local_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../model/auth/auth_user.dart';

final userRepository = Provider<User>(
  (ref) => UserImpl(
    ref.watch(localStorageProvider.future),
  ),
);

class UserImpl implements User {
  UserImpl(this._localStorage);

  final _log = Logger(filter: DevelopmentFilter());
  final Future<LocalStorage>? _localStorage;

  bool _isRegisterFlow = false;
  bool get isRegisterFlow => _isRegisterFlow;

  @override
  Future<void> setUserPinCode({required String pinCode}) async {
    AuthData? authData = await _localStorage?.then<AuthData?>(
      (storage) async => await storage.get(HiveStorageKeys.authDataBox,
          key: HiveTypeIdKeys.authDataTypeIdKey),
    );
    authData?.user?.pinCode = pinCode;
    await authData?.save();
    _log.d('Auth user from setUserPinCode() ${authData?.user?.email}');
  }

  @override
  Future<String?> getName() async {
    AuthData? authData = await _localStorage?.then<AuthData?>((storage) async =>
        await storage.get(HiveStorageKeys.authDataBox,
            key: HiveTypeIdKeys.authDataTypeIdKey));
    _log.d('Full name from getName() ${authData?.user?.fullName}');
    return authData?.user?.fullName;
  }

  @override
  void setIsRegisterFlow(bool value) {
    _isRegisterFlow = value;
  }
}
