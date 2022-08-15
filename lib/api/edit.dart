import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';

final ip = Config.Server;


Future <void> editRecord(String? id, String status, String? remarks) async{

try {
  String uri = "http://${ip}/incoming_data/edit_record.php";
  var res = await http.post(Uri.parse(uri), 

  body: {
        "id":id,
        "status": status,
        "remarks": remarks

  });

  var response = jsonDecode(res.body);

  if(response['success'] == "true")
  {
    print("record inserted");

  }
  else
  {
    print("Some Error");
  }
} catch (e) {
  print(e);
}


}