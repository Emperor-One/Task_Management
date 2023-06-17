import 'dart:convert';

import 'package:http/http.dart' as http;

String _baseUrl = "http://localhost:8000";

Future<dynamic> fetch() async {
  http.Response response = await http.get(Uri.parse("$_baseUrl/login"));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return (json);
  } else {
    throw Exception("Failure!");
  }
}

void main() async {
  var message = await fetch();
  print(message);
}
