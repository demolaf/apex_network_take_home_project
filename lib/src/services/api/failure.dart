class Failure {
  final String message;
  final Map<String, dynamic>? data;

  Failure({
    required this.message,
    this.data,
  });

  factory Failure.fromHttpErrorMap(Map<String, dynamic> json) => Failure(
        message: json["error"]["message"],
        data: json["data"],
      );

  @override
  String toString() {
    return 'Failure{message: $message, data: $data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          data == other.data;

  @override
  int get hashCode => message.hashCode ^ data.hashCode;
}
