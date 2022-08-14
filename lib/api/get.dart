import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Model.dart';




Future <List<Model>> getRecords() async
{
final response = await http
      .get(Uri.parse('http://192.168.1.12/incoming_data/get_data.php'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return modelFromJson(response.body);
  } else {
    print('Something went wrong');
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}