import 'package:employee_management/utils/constant.dart';
import 'package:http/http.dart' as http;

class UserDataRepository {
  /*
   * GET USER DATA AFTER AUTH
   * String Token
   * return jsonResponse
  */
  Future getMyData(String token) async {
    try {
      var response = await http.get(
        Uri.parse('$urlBackend/v1/user'),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accepet' : 'application/json',
        }
      );
      return response;
    } catch (e) {
      return 'Server Error';
    }
  }
}