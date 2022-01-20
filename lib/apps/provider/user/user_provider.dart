import 'dart:convert';

import 'package:employee_management/apps/repository/auth_repository.dart';
import 'package:employee_management/apps/repository/user_data_repository.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  UserDataRepository userDataRepository = UserDataRepository();
  AuthRepository authRepository = AuthRepository();
  Map<String, dynamic> _userData = {};
  bool _error = false;
  String _errorMessage = '';
  int? _statusRes;
  bool _isFetching = false;

  // GETTERS
  Map<String, dynamic> get userData => _userData;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  int? get statusRes => _statusRes;
  bool get isFetching => _isFetching;
  
  /*
   * GET USER DATA 
   */
  Future<void> get getUserData async {
    _isFetching = true;
    var token = await authRepository.hasToken();
    if (token != null) {
      http.Response res = await userDataRepository.getMyData(token);
      switch (res.statusCode) {
        case 200:
          _userData = jsonDecode(res.body);
          _error = false;
          _statusRes = 200;
          _isFetching = false;
          break;
        case 401:
          _userData = {};
          _error = true;
          _statusRes = 401;
          _errorMessage = 'Sesi Telah Habis. Anda akan keluar';
          _isFetching = false;
          break;
        case 500:
          _userData = {};
          _error = true;
          _statusRes = 500;
          _errorMessage = 'Tidak ada koneksi internet';
          _isFetching = false;
      }
    } else {
      await authRepository.unsetLocalToken();
      _userData = {};
      _error = true;
      _statusRes = 401;
      _errorMessage = 'Sesi Telah Habis. Anda akan keluar';
      _isFetching = false;

    }
    notifyListeners();
  }

  /*
   * Initial Value 
   */
  void initialValue() {
    _userData = {};
    _error = false;
    _statusRes = null;
    _errorMessage = '';
    _isFetching = false;
    notifyListeners();
  }
}
