import 'package:apex_network_take_home_project/src/core/constants/hive_type_id_keys.dart';
import 'package:hive/hive.dart';

part 'auth_user.g.dart';

class AuthResponse {
  bool? status;
  String? message;
  AuthData? data;

  AuthResponse({this.status, this.message, this.data});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AuthData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: HiveTypeIdKeys.authDataTypeIdKey)
class AuthData extends HiveObject {
  @HiveField(0)
  AuthUser? user;
  @HiveField(1)
  String? token;

  AuthData({this.user, this.token});

  AuthData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? AuthUser.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

@HiveType(typeId: HiveTypeIdKeys.authUserTypeIdKey)
class AuthUser {
  @HiveField(0)
  String? fullName;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? country;
  @HiveField(3)
  String? id;
  @HiveField(4)
  String? pinCode;

  AuthUser({this.fullName, this.email, this.country, this.id, this.pinCode});

  AuthUser.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    country = json['country'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['email'] = email;
    data['country'] = country;
    data['id'] = id;
    return data;
  }
}
