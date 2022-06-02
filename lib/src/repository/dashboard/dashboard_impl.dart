import 'package:apex_network_take_home_project/src/core/constants/api_base.dart';
import 'package:apex_network_take_home_project/src/model/dashboard/dashboard.dart';
import 'package:apex_network_take_home_project/src/services/api/api.dart';
import 'package:apex_network_take_home_project/src/services/api/api_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dashboard.dart';

/// DashboardImpl Repository Provider
final dashboardRepository = Provider(
  (ref) => DashboardImpl(
    ref.read(apiProvider),
  ),
);

class DashboardImpl implements Dashboard {
  DashboardImpl(this._api);

  final Api _api;

  @override
  Future<String?> getDashboardSecret() async {
    final response = await _api.get(ApiBase.dashboardBase(null));
    return DashboardResponse.fromJson(response).data?.secret;
  }
}
