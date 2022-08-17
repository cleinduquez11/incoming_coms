import 'package:google_fonts/google_fonts.dart';
import 'package:neomorph/api/range_picker.dart';

import 'api/get.dart';
import 'api/search.dart';
// import 'api/search_data.dart';
import 'designs/style.dart';
import 'models/Model.dart';

// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neomorph/api/delete.dart';
import 'package:neomorph/api/edit.dart';
import 'package:neomorph/api/post.dart';
// import 'package:neomorph/api/search_data.dart';
import 'package:neomorph/designs/style.dart';
import 'package:neomorph/loading.dart';
import 'package:neomorph/search.dart';

import 'api/config.dart';
import 'api/get.dart';
import 'models/Model.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
// import 'package:website/Models.dart';

final ip = Config.Server;


class From extends StatefulWidget {
  const From({Key? key,required this.from, required this.until}) : super(key: key);

  final String from;
  final String until;

  



  @override
  State<From> createState() => _FromState();
}

class _FromState extends State<From> {
  
  late Future<List<Model>> futureModels = getRecords();
  late Future<List<Model>> futureModels1 = searchRecord(searchcontroller.text);
   

  TextEditingController partcontroller = TextEditingController();
  TextEditingController agencycontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController statuscontroller = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController dateReceivedcontroller = TextEditingController();
  TextEditingController ctlncontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();

  ScrollController latestController = ScrollController();

  bool changeColor = false;
  final currentDay = DateTime.now().day;
  final currentMonth = DateTime.now().month.toString();
  final currentYear = DateTime.now().year;
  final dateNowFormat = DateFormat('MM-dd-yyyy').format(DateTime.now());

  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
           elevation: 10,
              bottom: TabBar(
                  automaticIndicatorColorAdjustment: false,
                  unselectedLabelColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.transparent,
    
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.038,
                              child: Text(
                                '',
                                style: subtitleFont(context),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                              child: Text(
                                'CONTROL NO.',
                                style: subtitleFont(context),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.07,
                              child: Center(
                                  child: Text(
                                'DATE RECEIVED',
                                style: subtitleFont(context),
                              ))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Center(
                                  child: Text(
                                'PARTICULARS',
                                style: subtitleFont(context),
                              ))),
                          // DataColumn(label: Text('OTM CONTROL NO.')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(
                                'AGENCY//OFFICE FROM',
                                style: subtitleFont(context),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                              child: Text(
                                'DATE MADE',
                                style: subtitleFont(context),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                  child: Text(
                                'Remarks',
                                style: subtitleFont(context),
                              ))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                              child: Text(
                                '',
                                style: subtitleFont(context),
                              )),
                        ]),
    
                    // Text(''),
                  ]),
              backgroundColor: NeumorphicTheme.baseColor(context),
    
        ),
           backgroundColor: NeumorphicTheme.baseColor(context),
        extendBodyBehindAppBar: true,
         body: FutureBuilder<List<Model>>(
    
              future: dateInBetweenRecord(widget.from, widget.until),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      controller: latestController,
                      // reverse: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return Neumorphic(
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(8)),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            child: DataTable(
    
                                //  showCheckboxColumn: true,
    
                                //  dividerThickness: 100,
                                // border: TableBorder.symmetric(
                                //   inside: BorderSide(
                                //       width: 2, style: BorderStyle.solid),
                                //   outside: BorderSide(
                                //       width: 2, style: BorderStyle.solid),
                                // ),
                                dataRowHeight: 40,
                                showBottomBorder: false,
                                headingRowHeight: 0,
                                // headingTextStyle: TextStyle(
                                //     fontWeight: FontWeight.bold, color: Colors.white),
                                // headingRowColor: MaterialStateProperty.resolveWith(
                                //     (states) => Color.fromARGB(255, 113, 198, 191)),
                                columns:
                                    //   [
                                    //   DataColumn(label: Text('CONTROL NO.'), tooltip: 'CONTROL NO.'),
                                    //   DataColumn(label: Text('DATE RECEIVED')),
                                    //   DataColumn(label: Text('PARTICULARS')),
                                    //   // DataColumn(label: Text('OTM CONTROL NO.')),
                                    //   DataColumn(label: Text('AGENCY//OFFICE FROM')),
                                    //   DataColumn(label: Text('DATE MADE')),
                                    //   DataColumn(label: Text('Remarks')),
                                    //   DataColumn(label: Text('')),
                                    //   DataColumn(label: Text('')),
                                    // ],
                                    // ignore: prefer_const_literals_to_create_immutables
                                    [
                                  const DataColumn(label: const Text('')),
                                  const DataColumn(label: const Text('')),
                                  const DataColumn(label: const Text('')),
                                  const DataColumn(label: const Text('')),
                                  // DataColumn(label: Text('OTM CONTROL NO.')),
                                  const DataColumn(label: const Text('')),
                                  const DataColumn(label: Text('')),
                                  const DataColumn(label: const Text('')),
                                  const DataColumn(label: Text('')),
                                ],
    
                                // ignore: prefer_const_literals_to_create_immutables
                                rows: [
                                  DataRow(
    
                                      // ignore: prefer_const_literals_to_create_immutables
                                      cells: [
                                        DataCell(SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.038,
                                          child: Text("${index + 1}",
                                              style: bodyFont(context)),
                                        )),
                                        DataCell(SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.08,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${snapshot.data![index].controlNumber}",
                                                  style: bodyFont(context)),
                                              // const Text("Control Num."),
                                            ],
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.06,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${snapshot.data![index].date}",
                                                  style: bodyFont(context)),
                                              // const Text("Date"),
                                            ],
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                  // style: TextButton.styleFrom(
                                                  //     // primary: changeColor ? Colors.blue : Colors.pink,
                                                  //     //primary: Colors.blue,
                                                  //     // onSurface: Colors.green,
                                                  //     ),
                                                  onPressed: () async {
                                                    // final ref = sref.child(
                                                    //     'files/${snapshot.data![index].part}.${snapshot.data![index].ext}');
                                                    // getdownloadLink(ref,
                                                    //     "${snapshot.data![index].part}.${snapshot.data![index].ext}");
                                                    // setState(() {
                                                    //   status1 = "Pending...";
                                                    // });
                                                    final url = await snapshot
                                                        .data![index].fileLink
                                                        .toString();
    
                                                    html.window.open(
                                                        'https://${ip}${url}',
                                                        '${snapshot.data![index].particulars}');
    
                                                    /////////////////////////////////////
    
                                                    //////////////////////////////////////////
                                                  },
                                                  child: Tooltip(
                                                      message:
                                                          "Click to Open file",
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          
                                                          Text(
                                                              "${snapshot.data![index].particulars}",
                                                              style: particularsFont(
                                                                  context)),
    
                                                                  Icon(Icons.file_download_outlined,
                                                                  size: 20,
                                                                  color: Colors.blue,
    
                                                                  ),
                                                        ],
                                                      ))),
                                              // const Text("Particular"),
                                            ],
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${snapshot.data![index].agency}",
                                                  style: bodyFont(context)),
                                              // const Text("agency"),
                                            ],
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.06,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${snapshot.data![index].datemade}",
                                                  style: bodyFont(context)),
                                              // const Text("Date Made")
                                            ],
                                          ),
                                        )),
                                        DataCell(Center(
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              child: Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: ((BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              
                                                              title: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  
                                                                  Text('${snapshot.data![index].particulars}',
                                                                  style: GoogleFonts.cinzel(
                                                                    color: Colors.black,
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight.w700
                                                                  ) ,
                                                                  ),
                                                                  SizedBox(height: 30,),
                                                                  Row(
                                                                    children: [
                                                                       Text(
                                                                          'status: ',
                                                                          style: GoogleFonts.nunito(
                                                                            color: Colors.black,
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w600
    
                                                                          ),
                                                                          ),
                                                                      Text(
                                                                        '${snapshot.data![index].status}',
                                                                        style: GoogleFonts.nunito(
                                                                          fontSize: 16,
                                                                            color: snapshot.data![index].status == 'terminated'
                                                                                ? const Color.fromARGB(255, 240, 28, 28)
                                                                                : snapshot.data![index].status == 'accomplished'
                                                                                    ? const Color.fromARGB(255, 35, 240, 28)
                                                                                    : snapshot.data![index].status == 'new'
                                                                                        ? const Color.fromARGB(255, 10, 151, 153)
                                                                                        : Color.fromARGB(255, 215, 164, 12),
                                                                        )
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              content: SizedBox(
                                                                // width: 200,
                                                                // height: 200,
                                                                child: Row(
                                                                  children: [
                                                                    Text("remarks: ",
                                                                    style: GoogleFonts.nunito(
                                                                      color: Colors.black,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w600
                                                                    )
                                                                    ),
                                                                    Text(
                                                                        '${snapshot.data![index].remarks}',
                                                                        style: GoogleFonts.nunito(
                                                                      color: Colors.black,
                                                                      fontSize: 16,
                                                                      fontStyle: FontStyle.italic
                                                                    )
                                                                        ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }));
    
                                                      // Navigator.of(context).pushReplacement(
                                                      //     MaterialPageRoute(
                                                      //         builder:
                                                      //             (BuildContext context) =>
                                                      //                 Try()));
                                                    },
                                                    child: Text(
                                                        "${snapshot.data![index].status}",
                                                        style: GoogleFonts.nunito(
                                                                          fontSize: 16,
                                                                            color: snapshot.data![index].status == 'terminated'
                                                                                ? const Color.fromARGB(255, 240, 28, 28)
                                                                                : snapshot.data![index].status == 'accomplished'
                                                                                    ? const Color.fromARGB(255, 35, 240, 28)
                                                                                    : snapshot.data![index].status == 'new'
                                                                                        ? const Color.fromARGB(255, 10, 151, 153)
                                                                                        : Color.fromARGB(255, 215, 164, 12),
                                                                        )
                                                        ),
                                                  ),
                                                  IconButton(
                                                      color: textColor(context),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                ((BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  
                                                                  Text('${snapshot.data![index].particulars}',
                                                                  style: GoogleFonts.cinzel(
                                                                    color: Colors.black,
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight.w700
                                                                  ) ,
                                                                  ),
                                                                  SizedBox(height: 30,),
                                                                  
                                                                ],
                                                              ),
                                                         
                                                                content: Container(
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all()
                                                                  ),
                                                                  height: 250,
                                                                  width: 100,
                                                                  child: Column(
                                                                    children: [
                                                                      TextFormField(
                                                                        controller:
                                                                            statuscontroller,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          label:
                                                                              Text(
                                                                            'Status',
                                                                          ),
                                                                          labelStyle: TextStyle(
                                                                              color:
                                                                                  Colors.black,
                                                                              fontSize: 16),
                                                                        ),
                                                                        validator:
                                                                            (value) {
                                                                          if (value!
                                                                              .isEmpty) {
                                                                            return "This field shouldn't be empty";
                                                                          }
                                                                        },
                                                                      ),
                                                                      TextFormField(
                                                                        showCursor: false,
                                                                        cursorColor: Colors.white,
                                                                        controller:
                                                                            remarkscontroller,
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .multiline,
                                                                        maxLines:
                                                                            null,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          label:
                                                                              Text(
                                                                            'Remarks',
                                                                          ),
                                                                          labelStyle: TextStyle(
                                                                              color:
                                                                                  Colors.black,
                                                                              fontSize: 16),
                                                                        ),
                                                                        validator:
                                                                            (value) {
                                                                          if (value!
                                                                              .isEmpty) {
                                                                            return "This field shouldn't be empty";
                                                                          }
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  NeumorphicButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (statuscontroller
                                                                                .text
                                                                                .isEmpty &&
                                                                            remarkscontroller
                                                                                .text
                                                                                .isEmpty) {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          // final snackBar =
                                                                          //     SnackBar(
                                                                          //   backgroundColor:
                                                                          //       textColor(context),
                                                                          //   content:
                                                                          //       Text(
                                                                          //     'Please provide all the requested information',
                                                                          //     style:
                                                                          //         rodyFont(context),
                                                                          //   ),
                                                                          //   duration:
                                                                          //       Duration(seconds: 3),
                                                                          // );
    
                                                                          // // Find the ScaffoldMessenger in the widget tree
                                                                          // // and use it to show a SnackBar.
                                                                          // ScaffoldMessenger.of(context)
                                                                          //     .showSnackBar(snackBar);
                                                                        } else {
                                                                          editRecord(
                                                                              "${snapshot.data![index].id}",
                                                                              statuscontroller.text,
                                                                              remarkscontroller.text);
    
                                                                               Navigator.of(
                                                                                context)
                                                                            .pushReplacement(
                                                                                MaterialPageRoute(builder: (BuildContext context) => Search(search: '',)));
                                                                        }
    
                                                                        // dref
                                                                        //     .child(
                                                                        //         '${keys[index]}')
                                                                        //     .update({
                                                                        //   'status':
                                                                        //       statuscontroller
                                                                        //           .text,
                                                                        //   'remarks':
                                                                        //       remarkscontroller
                                                                        //           .text
                                                                        // });
                                                                       
                                                                      },
                                                                      child: Text(
                                                                        "Save",
                                                                        style: TextStyle(
                                                                            color:
                                                                                textColor(context)),
                                                                      ))
                                                                ],
                                                              );
                                                            }));
                                                        // Navigator.of(context)
                                                        //     .pushReplacement(
                                                        //         MaterialPageRoute(
                                                        //             builder: (BuildContext
                                                        //                     context) =>
                                                        //                 Try()));
                                                      },
                                                      icon:
                                                          const Icon(Icons.edit))
                                                ],
                                              )),
                                        )),
                                        DataCell(Tooltip(
                                          message: "Click to Delete",
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            child: Center(
                                              child: IconButton(
                                                  onPressed: () async {
                                                    deleteRecord(
                                                        "${snapshot.data![index].id}");
                                                    // dref.child('${keys[index]}').remove();
                                                    // sref
                                                    //     .child(
                                                    //         'files/${snapshot.data![index].part}.${snapshot.data![index].ext}')
                                                    //     .delete();
    
                                                    final snackBar = SnackBar(
                                                      backgroundColor:
                                                          textColor(context),
                                                      content: Text(
                                                        'Successfully Deleted',
                                                        style: TextStyle(
                                                            color: rextColor(
                                                                context)),
                                                      ),
                                                      duration:
                                                          Duration(seconds: 3),
                                                    );
    
                                                    // Find the ScaffoldMessenger in the widget tree
                                                    // and use it to show a SnackBar.
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(snackBar);
    
                                                    // const CircularProgressIndicator();
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            maintainState: false,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                Search(search: '',)));
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.redAccent,
                                                    size: 26,
                                                  )),
                                            ),
                                          ),
                                        ))
                                      ])
                                ]),
                          ),
                        );
                      }));
                }
    
                return Loading();
              })),
      
    
    
      ),
    );
    
  }
}