import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class NetworkHelper {
  Future<dynamic> post(String endPoint, Map<String, Object> data) {
    return http.post(Uri.parse(apiUrl + endPoint), body: data).then((response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        var result = jsonDecode(res);
        var data = result;
        if (data.containsKey('message')) {
          throw new Exception(result['message']);
        } else {
          throw new Exception(data);
        }
      }
      if(res == ""){
        return res;
      }
      return jsonDecode(res);
    });
  }


  Future<dynamic> get(String endPoint) async {
    return http.get(Uri.parse(apiUrl + endPoint),
        headers: {"Accept": "application/json"}).then((response) {
      if (response.statusCode < 200 || response.statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      return jsonDecode(response.body);
    });
  }
}
