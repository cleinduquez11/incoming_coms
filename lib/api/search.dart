import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Model.dart';
import 'config.dart';

final ip = Config.Server;


Future <List<Model>>  searchRecord( String? search) async{

  String uri = "http://${ip}/incoming_data/get_data.php";
  var res = await http.post(Uri.parse(uri), 

  body: {
        "search": search
  });

  var response = jsonDecode(res.body);

  // print(response);

  return modelFromJson(res.body);



}