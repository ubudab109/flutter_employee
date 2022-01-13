class ExceptionMessage {
  bool? success;
  String? message;

  ExceptionMessage({
    this.success,
    this.message
  });

  ExceptionMessage.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}