class TokenAuth {
  String? token;
  String? expiredToken;
  TokenAuth({this.token, this.expiredToken});

  TokenAuth.fromJson(Map<String, dynamic> data) {
    token = data['token'];
    expiredToken = data['expired_token'];
  }
}

class LoginAuth {
  bool? success;
  String? message;
  TokenAuth? token;

  LoginAuth.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = TokenAuth.fromJson(json);
  }
}
