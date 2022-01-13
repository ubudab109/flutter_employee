class UserData {
  String? fullname;
  String? nip;
  String? role;
  UserData({
    required this.fullname,
    required this.nip,
    required this.role,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    fullname = json['data']['fullname'];
    nip = json['data']['nip'];
    role = json['data']['role'];
  }
}