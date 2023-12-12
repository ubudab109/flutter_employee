
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
      var response = await http.get(Uri.parse('$urlBackend/v1/user'), headers: {
        'Authorization': 'Bearer $token',
        'Accepet': 'application/json',
      });
      return response;
    } catch (e) {
      return 'Server Error';
    }
  }

  /*
   * UPLOAD IMAGE
   * String Token
   * return jsonResponse
  */
  Future<String> uploadPictureImages(String token, String file) async {
    try {
      String addimageUrl = '$urlBackend/v1/profile/picture';
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      };
      var request = http.MultipartRequest('POST', Uri.parse(addimageUrl));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('file', file));

      var response = await request.send();
      if (response.statusCode == 200) {
        return 'Upload Success';
      } else {
        return 'Harap Periksa Gambar Anda. Maksimal Gambar Adalah 2 MB dan Format Yang Diperbolehkan Hanya JPG, JPEG dan PNG';
      }
    } catch (e) {
      return 'Server Error';
    }
  }
}
