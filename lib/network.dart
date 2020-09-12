import 'package:http/http.dart';
import 'dart:convert';

class Network {
  String url;
  Network({this.url});
  Future getData() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      print(url);
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }
}
