
import 'package:employee_management/utils/constant.dart';
import 'package:http/http.dart' as http;

class NoteDataRepository {
  /* 
  * GET NOTE DATE USER
  * String Token
  * return jsonResponse
 */
  Future getNoteDate(String token) async {
    try {
      var response =
          await http.get(Uri.parse('$urlBackend/v1/home/event-note'), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });
      return response;
    } catch (e) {
      return e;
    }
  }

  /*
   * GET NOTE DATA USER BY DATE
   * String Token
   * String date
   * return jsonResponse
  */
  Future getNoteData(String token, String date) async {
    try {
      var response = await http
          .get(Uri.parse('$urlBackend/v1/home/note?date=$date'), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return e;
    }
  }

  /*
   * POST NOTE DATA USER BY DATE
   * String Token
   * String date
   * String time
   * String note
   * return jsonResponse
  */
  Future postNoteData(String token, String date, String time, String note,
      String? color) async {
    try {
      var response = await http.post(Uri.parse('$urlBackend/v1/home/note'), body: {
        'date': date,
        'time': time,
        'note': note,
        'color': color!
      }, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return e;
    }
  }

  /*
   * DELETE NOTE DATA USER BY ID
   * String Token
   * int id of note data
   * return jsonResponse
  */
  Future deleteNoteData(String token, int id) async {
    try {
      var response = await http.delete(Uri.parse('$urlBackend/v1/home/note/$id'), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return e;
    }
  }
}
