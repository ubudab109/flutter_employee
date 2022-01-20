// ignore_for_file: unnecessary_null_comparison, unrelated_type_equality_checks

import 'dart:convert';
import 'package:employee_management/apps/my_app.dart';
import 'package:employee_management/apps/repository/auth_repository.dart';
import 'package:employee_management/pages/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  AuthRepository authRepository = AuthRepository();
  TextEditingController credential = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loadingLogin = false;
  bool loadingLogout = false;
  Widget? childAuth;

  /*
   * LOGIN PROVIDER
   */
  Future<void> login(BuildContext context) async {
    if (credential.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harap mengisi semua form')));
      return;
    }

    loadingLogin = true;
    notifyListeners();
    http.Response res =
        await authRepository.loginUser(credential.text, password.text);
    var data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      await authRepository.setLocalToken(
          data['data']['token'], data['data']['expired_token']);
      loadingLogin = false;
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    } else {
      loadingLogin = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
    }
  }

  /*
   * LOGOUT PROVIDER
   */
  Future<void> logout(BuildContext context) async {
    loadingLogout = true;
    notifyListeners();

    var token = await authRepository.hasToken();

    http.Response res = await authRepository.logout(token);

    var data = jsonDecode(res.body);
    loadingLogout = false;
    notifyListeners();

    if (res.statusCode == 200) {
      await authRepository.unsetLocalToken();
      notifyListeners();
      Navigator.of(context, rootNavigator: true)
          .pushReplacement(MaterialPageRoute(builder: (context) => const Auth()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
    }
  }
}
