import 'package:employee_management/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {

  /*
   * LOGIN USER
   * String _credential (email, phone number)
   * String Password
   * return jsonResponse to LoginAuth Model
  */
  Future loginUser(String _credential, String password) async {
    try {
      var response = await http.post(
        Uri.parse('$urlBackend/v1/login'),
        body: {
          'credential': _credential,
          'password': password,
        });
        return response;
    } catch (e) {
      return e;
    }
  }

  /*
   * GET USER DATA AFTER AUTH
   * String Token
   * return jsonResponse to UserData Model
  */
  Future getMyData(String token) async {
    try {
      var response = await http.get(
        Uri.parse(urlBackend + 'v1/user'),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accepet' : 'application/json',
        }
      );
      return response;
    } catch (e) {
      return e;
    }
  }
  /*
   * LOGOUT USER
   * String token
   * return jsonResponse to LogoutAuth Model
  */
  Future logout(String token) async {
    try {
      var response = await http.post(
        Uri.parse('$urlBackend/v1/logout'),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accepet' : 'application/json',
        }
      );
      return response;
    } catch (e) {
      return e;
    }
  }

  /*
   * GET TOKEN
   * return String token
  */
  Future hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String? token = local.getString("token");
    return token;
  }

  /*
   * SET TOKEN
   * param String token
  */
  Future setLocalToken(String token, String expired) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString('token', token);
    local.setString('expired', expired.toString());
  }

  /*
   * UNSET TOKEN
  */
  Future unsetLocalToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.remove('token');
    local.remove('expired');
  }
}