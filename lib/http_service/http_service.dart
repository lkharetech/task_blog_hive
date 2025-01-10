import 'package:http/http.dart' as http;

class HttpService {
  static Future<http.Response?> postAPI({
    required String apiURL,
    Object? body,
    Map<String, String>? headers,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(apiURL),
        body: body,
        headers: headers,
      );

      return response;
    } catch (e) {
      print('error Exception POST API :::::: $e');
      return null;
    }
  }
}