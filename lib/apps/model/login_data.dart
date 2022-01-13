// ignore_for_file: non_constant_identifier_names

class LoginData {
  String? fullname;
  String? nip;
  String? role;
  LoginData({
    required this.fullname,
    required this.nip,
    required this.role,
  });

  LoginData.fromJson(Map<String, dynamic> data) {
    fullname = data['fullname'];
    nip = data['nip'];
    role = data['role'];
  }
}

