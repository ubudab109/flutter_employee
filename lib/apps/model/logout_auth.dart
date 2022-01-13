class LogoutAuth {
  bool? success;
  String? message;

  LogoutAuth({
    this.success,
    this.message
  });

  LogoutAuth.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}