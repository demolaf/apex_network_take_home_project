class EmailTokenVerifyResponse {
  bool? status;
  String? message;
  EmailTokenVerifyData? data;

  EmailTokenVerifyResponse({this.status, this.message, this.data});

  EmailTokenVerifyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? EmailTokenVerifyData.fromJson(json['data'])
        : null;
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

class EmailTokenVerifyData {
  String? token;

  EmailTokenVerifyData({this.token});

  EmailTokenVerifyData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
