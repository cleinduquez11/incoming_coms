import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Model.dart';
import 'config.dart';

final ip = Config.Server;


Future <List<Model>>  dateInBetweenRecord( String? from, String? until) async{

  String uri = "http://${ip}/incoming_data/from_until.php";
  var res = await http.post(Uri.parse(uri), 

  body: {
        "from": from,
        "until": until
  });

  var response = jsonDecode(res.body);

  print(response);

  // print(response);

  return modelFromJson(res.body);



}