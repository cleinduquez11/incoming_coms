import 'dart:convert';

import 'package:http/http.dart' as http;

Future <void> createRecord(String? particular, String? agency, String? datemade, String? status, String? remarks, String? controlNumber, String? date, String? fileLink) async{

try {
  String uri = "http://192.168.1.12/incoming_data/insert_record.php";
  var res = await http.post(Uri.parse(uri), 

  body: {
        "particular": particular,
        "agency": agency,
        "status": status,
        "remarks": remarks,
        "controlNumber": controlNumber,
        "date": date,
        "datemade": datemade,
        "file_link": fileLink,

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