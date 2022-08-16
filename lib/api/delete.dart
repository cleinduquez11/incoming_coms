import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';

final ip = Config.Server;


Future <void> deleteRecord(String? id) async{

try {
  String uri = "http://${ip}/incoming_data/delete_record.php";
  var res = await http.post(Uri.parse(uri), 

  
  
  body: {
        "id":id

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