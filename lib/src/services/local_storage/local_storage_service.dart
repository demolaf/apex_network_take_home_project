import 'package:apex_network_take_home_project/src/services/local_storage/local_storage.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../model/auth/auth_user.dart';

/// LocalStorageProvider Provider
final localStorageProvider = FutureProvider<LocalStorage>(
  (ref) async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    return LocalStorageService();
  },
);

class LocalStorageService implements LocalStorage {
  LocalStorageService() {
    initialize();
  }

  final _log = Logger(filter: DevelopmentFilter());

  /// Initialize local storage service and set1up hive adapters
  void initialize() {
    _setupAllHiveTypeAdapters();
    _log.i('Local storage service initialized');
  }

  /// Register Hive adapters
  static void _setupAllHiveTypeAdapters() {
    Hive.registerAdapter(AuthDataAdapter());
    Hive.registerAdapter(AuthUserAdapter());
  }

  @override
  Future<int?> add(String boxIdentifier, {required value}) async {
    Box? box;
    try {
      box = await Hive.openBox(boxIdentifier);
    } catch (e) {
      _log.e(e);
    }
    return await box?.add(value);
  }

  @override
  Future<void> delete(String boxIdentifier, {key}) async {
    try {
      final box = await Hive.openBox(boxIdentifier);
      await box.delete(key);
    } catch (e) {
      _log.e(e);
    }
  }

  @override
  Future<dynamic> get(String boxIdentifier, {key}) async {
    Box? box;
    try {
      box = await Hive.openBox(boxIdentifier);
    } catch (e) {
      _log.e(e);
    }
    return box?.get(key);
  }

  @override
  Future<void> put(String boxIdentifier, {key, value}) async {
    try {
      final box = await Hive.openBox(boxIdentifier);
      await box.put(key, value);
      _log.d("Successful - ${box.containsKey(key)} PUT $value");
    } catch (e) {
      _log.e(e);
    }
  }
}
