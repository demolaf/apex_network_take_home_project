class DashboardResponse {
  bool? status;
  String? message;
  Data? data;

  DashboardResponse({this.status, this.message, this.data});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? secret;

  Data({this.secret});

  Data.fromJson(Map<String, dynamic> json) {
    secret = json['secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secret'] = secret;
    return data;
  }
}
