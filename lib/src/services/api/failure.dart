/// Error handling class for throwing and catching api errors
class Failure {
  final String message;
  final List<dynamic>? data;
  final Map<String, dynamic>? errors;

  Failure({required this.message, this.data, this.errors});

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        message: json["message"],
        data: json["data"],
        errors: json["errors"],
      );

  @override
  String toString() {
    return 'Failure{message: $message, data: $data, errors: $errors}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          data == other.data &&
          errors == other.errors;

  @override
  int get hashCode => message.hashCode ^ data.hashCode ^ errors.hashCode;
}

class AuthError {
  bool? status;
  String? message;
  Errors? errors;

  AuthError({this.status, this.message, this.errors});

  AuthError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email;
  List<String>? password;

  Errors({this.email, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
    password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
