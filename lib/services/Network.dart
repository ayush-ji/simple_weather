import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiCall {
  String _api = "";
  var _jsonBody;
  late int statusCode;

  ApiCall ({api : String}) {
    this._api = api;
  }

  Future<void> fetchData() async {
    Uri uri = Uri.parse(_api);
    print("$uri is our api");
    var data = await http.get(uri);
    _jsonBody = jsonDecode(data.body);
  }

  Future<dynamic> getJSON() async {
    return _jsonBody;
  }

}