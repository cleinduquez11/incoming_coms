
import 'package:meta/meta.dart';
import 'dart:convert';

List<Model> modelFromJson(String str) => List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
    Model({
        @required this.id,
        @required this.particulars,
        @required this.agency,
        @required this.status,
        @required this.remarks,
        @required this.controlNumber,
        @required this.date,
        @required this.datemade,
        @required this.fileLink,
        @required this.search,
        @required this.from,
        @required this.until,

    });

    String? id;
    String? particulars;
    String? agency;
    String? status;
    String? remarks;
    String? controlNumber;
    String? date;
    String? datemade;
    String? fileLink;
    String? search;
    String? from;
    String? until;

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        particulars: json["particulars"],
        agency: json["agency"],
        status: json["status"],
        remarks: json["remarks"],
        controlNumber: json['control number'],
        date: json['date'],
        datemade: json['datemade'],
        fileLink: json["file_link"],
        search: json["search"],
        from: json["from"],
        until: json["until"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "particulars": particulars,
        "agency": agency,
        "status": status,
        "remarks": remarks,
        "control number": controlNumber,
        "date": date,
        "datemade": datemade,
        "file_link": fileLink,
        "search": search,
        "from": from,
        "until": until
    };
}
