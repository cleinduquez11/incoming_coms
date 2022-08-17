// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neomorph/api/delete.dart';
import 'package:neomorph/api/edit.dart';
import 'package:neomorph/api/post.dart';
import 'package:neomorph/api/search.dart';
import 'package:neomorph/designs/style.dart';
import 'package:neomorph/loading.dart';
import 'package:neomorph/search.dart';

import 'api/config.dart';
import 'api/get.dart';
import 'from.dart';
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

class Home extends StatefulWidget {
  const Home({Key? key,}) : super(key: key);
  // final String? search;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Model>> futureModels = getRecords();
  late Future<List<Model>> futureModels1 = searchRecord(searchcontroller.text);
   

  TextEditingController partcontroller = TextEditingController();
  TextEditingController agencycontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController statuscontroller = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController dateReceivedcontroller = TextEditingController();
  TextEditingController ctlncontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController(text: '');
  TextEditingController fromcontroller = TextEditingController(text: '');
  TextEditingController untilcontroller = TextEditingController(text: '');

  ScrollController latestController = ScrollController();

  bool changeColor = false;
  final currentDay = DateTime.now().day;
  final currentMonth = DateTime.now().month.toString();
  final currentYear = DateTime.now().year;
  final dateNowFormat = DateFormat('MM-dd-yyyy').format(DateTime.now());

  PlatformFile? selectedFile;

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) {
    } else {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  Future uploadFile() async {
    Uint8List bytes = selectedFile!.bytes as Uint8List;
    final ext = selectedFile!.extension;
    final filename = selectedFile!.name.replaceAll('.${ext}', '');

// print(filename);
//print(selectedFile);
// print(filename);
    final data = {
      "user_file": base64Encode(bytes),
      "user_file_name": filename,
      "user_file_extension": ext,
    };

    String url = "https://${ip}/incoming_data/upload_file.php";
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));

      final message = jsonDecode(response.body);
// print(bytes);
// print(filename);
// print(ext);
// print(message);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    partcontroller.dispose();
    agencycontroller.dispose();
    remarkscontroller.dispose();
    dateReceivedcontroller.dispose();
    datecontroller.dispose();
    statuscontroller.dispose();
    ctlncontroller.dispose();
    searchcontroller.dispose();
    fromcontroller.dispose();
    untilcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int num1;
    final format = DateFormat("MM/dd/yyyy");
    final format1 = DateFormat("yyyy-MM-dd");
    final format2 = DateFormat("yyyy-MM-dd");
    String string = "Upload";
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: AppBar(
            leading: Icon(Icons.newspaper,
            color: textColor(context),
            size: 26,
            ),
            actions: [

                NeumorphicButton(
                  margin: EdgeInsets.all(12),
                  onPressed: () {
                   showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            child: AlertDialog(
                              contentPadding: EdgeInsets.all(30),
                              backgroundColor:
                                  NeumorphicTheme.baseColor(context),
                              scrollable: true,
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    disableDepth: true,
                                    // shape: NeumorphicShape.convex,
                                    // color: Colors.grey,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                    style: bodyFont(context),
                                      controller: searchcontroller,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(      
                                          borderSide: BorderSide(color: Colors.cyan),   
                      ),  
                                        hintText: "search for particulars, agency, control number or status",
                                        hintStyle: particularsFont(context),
                                        fillColor: rextColor(context)

                                      ),

                                  )
                                ),
                              ),
                                     actions: [
                                NeumorphicButton(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8)),
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                    onPressed: () async {
                                      if (searchcontroller.text.isEmpty) {
                                        Navigator.of(context).pop();
                                        // final snackBar = SnackBar(
                                        //   backgroundColor: textColor(context),
                                        //   content: Text(
                                        //     'Please provide all the requested information',
                                        //     style: rodyFont(context),
                                        //   ),
                                        //   duration: Duration(seconds: 3),
                                        // );

                                        // // Find the ScaffoldMessenger in the widget tree
                                        // // and use it to show a SnackBar.
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(snackBar);
                                      }
                                      // else if (parts
                                      //     .contains(partcontroller.text)) {
                                      //   Navigator.of(context).pop();
                                      //   const snackBar = SnackBar(
                                      //     backgroundColor:
                                      //         Color.fromARGB(255, 210, 48, 36),
                                      //     content: Text(
                                      //       "Particular field shouldn't be repeated",
                                      //       style: TextStyle(
                                      //         color: Color.fromARGB(
                                      //             255, 255, 255, 255),
                                      //         // letterSpacing: 1,
                                      //         fontSize: 13,
                                      //         // fontWeight: FontWeight.w800
                                      //       ),
                                      //     ),
                                      //     duration: Duration(seconds: 3),
                                      //   );

                                      //   // Find the ScaffoldMessenger in the widget tree
                                      //   // and use it to show a SnackBar.
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(snackBar);
                                      // }
                                      else {
                                      //  searchRecord(searchcontroller.text);
                                        // Navigator.pop(context);

                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Search(search: searchcontroller.text,)));

                                        //  html.window.location.reload();
                                        // latestController.animateTo(
                                        //   latestController
                                        //       .position.maxScrollExtent,
                                        //   duration: Duration(milliseconds: 500),
                                        //   curve: Curves.linear,
                                        // );
                                      }

                                      // await  eref.child('Incoming Datas').push().set({
                                      //     "Particulars": partcontroller.text,
                                      //     "Agency": agencycontroller.text,
                                      //     "DateMade": datecontroller.text
                                      //   });

                                      // html.window.location.reload();
                                      //  setState(() {
                                      //    (context as Element).performRebuild();
                                      //  });
                                    },
                                    child: Center(
                                      child: Text("Search",
                                          style: bodyFont(context)),
                                    ))
                              ],
                            ),
                          );
                        });
              
                    //Navigator.pushNamed(context, 'home');
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(Icons.search_rounded,
                  color: textColor(context),
                  size: 20,
                  )
                  
                  ),



              NeumorphicButton(
                  margin: EdgeInsets.all(12),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            child: AlertDialog(
                              contentPadding: EdgeInsets.all(30),
                              backgroundColor:
                                  NeumorphicTheme.baseColor(context),
                              scrollable: true,
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    disableDepth: true,
                                    // shape: NeumorphicShape.convex,
                                    // color: Colors.grey,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text('Filter by date received',
                                      style: addtitleFont(context)),
                                ),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    disableDepth: true,
                                    color: Colors.grey,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: SizedBox(
                                      width: 400,
                                      child: Column(children: <Widget>[
                                        // TextFormField(
                                        //   // controller: emailController,
                                        //   decoration: InputDecoration(hintText: 'Particulars'),
                                        // ),
   

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            padding: const EdgeInsets.all(12.0),
                                            child: DateTimeField(
                                                style: bodyFont(context),
                                                validator: (date) {
                                                  if (date! == null) {
                                                    return ("This field shouldn't be empty");
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  label: Text(
                                                    'From',
                                                    style: bodyFont(context),
                                                  ),
                                                ),
                                                format: format,
                                                controller:
                                                    dateReceivedcontroller,
                                                onShowPicker:
                                                    (context, currentValue) {
                                                  return showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1900),
                                                      initialDate:
                                                          currentValue ??
                                                              DateTime.now(),
                                                      lastDate: DateTime(2100));
                                                }),
                                          ),
                                        ),

                                         // TextFormField(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            padding: const EdgeInsets.all(12.0),
                                            child: DateTimeField(
                                                style: bodyFont(context),
                                                validator: (date) {
                                                  if (date! == null) {
                                                    return ("This field shouldn't be empty");
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  label: Text(
                                                    'Until',
                                                    style: bodyFont(context),
                                                  ),
                                                ),
                                                format: format,
                                                controller: datecontroller,
                                                onShowPicker:
                                                    (context, currentValue) {
                                                  return showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1900),
                                                      initialDate:
                                                          currentValue ??
                                                              DateTime.now(),
                                                      lastDate: DateTime(2100));
                                                }),
                                          ),
                                        ),

                                        // Padding(
                                        //   padding: const EdgeInsets.all(12.0),
                                        //   child: Center(
                                        //     child: Neumorphic(
                                        //       style: NeumorphicStyle(
                                        //         shape: NeumorphicShape.flat,
                                        //         boxShape: NeumorphicBoxShape
                                        //             .roundRect(
                                        //                 BorderRadius.circular(
                                        //                     8)),
                                        //       ),
                                        //       padding:
                                        //           const EdgeInsets.all(12.0),
                                        //       child: IconButton(
                                        //           icon: Icon(
                                        //             color: textColor(context),
                                        //             Icons.upload_file,
                                        //             size: 30,
                                        //           ),
                                        //           onPressed: pickFile),
                                        //     ),
                                        //   ),
                                        // ),
                                        // selectedFile == null
                                        //     ? Text(
                                        //         'Select a File',
                                        //         style: bodyFont(context),
                                        //       )
                                        //     : Text(selectedFile!.name),

                                        //    controller: emailController,
                                        //   decoration: InputDecoration(hintText: 'Date Made'),
                                        // ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                NeumorphicButton(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8)),
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                    onPressed: () async {
                                      if (fromcontroller.text.isEmpty || untilcontroller.text.isEmpty) {
                                        Navigator.of(context).pop();
                                      
                                      }
                                      // else if (parts
                                      //     .contains(partcontroller.text)) {
                                      //   Navigator.of(context).pop();
                                      //   const snackBar = SnackBar(
                                      //     backgroundColor:
                                      //         Color.fromARGB(255, 210, 48, 36),
                                      //     content: Text(
                                      //       "Particular field shouldn't be repeated",
                                      //       style: TextStyle(
                                      //         color: Color.fromARGB(
                                      //             255, 255, 255, 255),
                                      //         // letterSpacing: 1,
                                      //         fontSize: 13,
                                      //         // fontWeight: FontWeight.w800
                                      //       ),
                                      //     ),
                                      //     duration: Duration(seconds: 3),
                                      //   );

                                      //   // Find the ScaffoldMessenger in the widget tree
                                      //   // and use it to show a SnackBar.
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(snackBar);
                                      // }
                                      else {
                                        
                                          print('yeah');
                                         Navigator.pop(context);

                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder:
                                        //             (BuildContext context) =>
                                        //                 From(from: fromcontroller.text, until: untilcontroller.text,)));

                                        //  html.window.location.reload();
                                        // latestController.animateTo(
                                        //   latestController
                                        //       .position.maxScrollExtent,
                                        //   duration: Duration(milliseconds: 500),
                                        //   curve: Curves.linear,
                                        // );
                                      }

                                      // await  eref.child('Incoming Datas').push().set({
                                      //     "Particulars": partcontroller.text,
                                      //     "Agency": agencycontroller.text,
                                      //     "DateMade": datecontroller.text
                                      //   });

                                      // html.window.location.reload();
                                      //  setState(() {
                                      //    (context as Element).performRebuild();
                                      //  });
                                    },
                                    child: Center(
                                      child: Text("Submit",
                                          style: addtitleFont(context)),
                                    ))
                              ],
                            ),
                          );
                        });
              
                    //Navigator.pushNamed(context, 'home');
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Filter",
                    style: bodyFont(context),
                  )),

              NeumorphicButton(
                  margin: EdgeInsets.all(12),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            child: AlertDialog(
                              contentPadding: EdgeInsets.all(30),
                              backgroundColor:
                                  NeumorphicTheme.baseColor(context),
                              scrollable: true,
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    disableDepth: true,
                                    // shape: NeumorphicShape.convex,
                                    // color: Colors.grey,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text('Add New',
                                      style: addtitleFont(context)),
                                ),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    disableDepth: true,
                                    color: Colors.grey,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: SizedBox(
                                      width: 600,
                                      child: Column(children: <Widget>[
                                        // TextFormField(
                                        //   // controller: emailController,
                                        //   decoration: InputDecoration(hintText: 'Particulars'),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            padding: const EdgeInsets.all(12.0),
                                            child: TextFormField(
                                              style: bodyFont(context),
                                              controller: partcontroller,
                                              decoration: InputDecoration(
                                                label: Text(
                                                  'Particulars',
                                                  style: bodyFont(context),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "This field shouldn't be empty";
                                                }
                                              },
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            padding: const EdgeInsets.all(12.0),
                                            child: TextFormField(
                                              style: bodyFont(context),
                                              controller: ctlncontroller,
                                              decoration: InputDecoration(
                                                label: Text(
                                                  'Control number',
                                                  style: bodyFont(context),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return ("This field shouldn't be empty");
                                                }
                                              },
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            padding: const EdgeInsets.all(12.0),
                                            child: DateTimeField(
                                                style: bodyFont(context),
                                                validator: (date) {
                                                  if (date! == null) {
                                                    return ("This field shouldn't be empty");
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  label: Text(
                                                    'Date Received',
                                                    style: bodyFont(context),
                                                  ),
                                                ),
                                                format: format,
                                                controller:
                                                    dateReceivedcontroller,
                                                onShowPicker:
                                                    (context, currentValue) {
                                                  return showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1900),
                                                      initialDate:
                                                          currentValue ??
                                                              DateTime.now(),
                                                      lastDate: DateTime(2100));
                                                }),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            padding: const EdgeInsets.all(12.0),
                                            child: TextFormField(
                                              style: bodyFont(context),
                                              controller: agencycontroller,
                                              decoration: InputDecoration(
                                                label: Text(
                                                  'Agency',
                                                  style: bodyFont(context),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return ("This field shouldn't be empty");
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        // TextFormField(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            padding: const EdgeInsets.all(12.0),
                                            child: DateTimeField(
                                                style: bodyFont(context),
                                                validator: (date) {
                                                  if (date! == null) {
                                                    return ("This field shouldn't be empty");
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  label: Text(
                                                    'Date Made',
                                                    style: bodyFont(context),
                                                  ),
                                                ),
                                                format: format,
                                                controller: datecontroller,
                                                onShowPicker:
                                                    (context, currentValue) {
                                                  return showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1900),
                                                      initialDate:
                                                          currentValue ??
                                                              DateTime.now(),
                                                      lastDate: DateTime(2100));
                                                }),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Center(
                                            child: Neumorphic(
                                              style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: IconButton(
                                                  icon: Icon(
                                                    color: textColor(context),
                                                    Icons.upload_file,
                                                    size: 30,
                                                  ),
                                                  onPressed: pickFile),
                                            ),
                                          ),
                                        ),
                                        selectedFile == null
                                            ? Text(
                                                'Select a File',
                                                style: bodyFont(context),
                                              )
                                            : Text(selectedFile!.name),

                                        //    controller: emailController,
                                        //   decoration: InputDecoration(hintText: 'Date Made'),
                                        // ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                NeumorphicButton(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8)),
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                    onPressed: () async {
                                      if (partcontroller.text.isEmpty ||
                                          agencycontroller.text.isEmpty ||
                                          datecontroller.text.isEmpty ||
                                          selectedFile == null) {
                                        Navigator.of(context).pop();
                                        final snackBar = SnackBar(
                                          backgroundColor: textColor(context),
                                          content: Text(
                                            'Please provide all the requested information',
                                            style: rodyFont(context),
                                          ),
                                          duration: Duration(seconds: 3),
                                        );

                                        // Find the ScaffoldMessenger in the widget tree
                                        // and use it to show a SnackBar.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                      // else if (parts
                                      //     .contains(partcontroller.text)) {
                                      //   Navigator.of(context).pop();
                                      //   const snackBar = SnackBar(
                                      //     backgroundColor:
                                      //         Color.fromARGB(255, 210, 48, 36),
                                      //     content: Text(
                                      //       "Particular field shouldn't be repeated",
                                      //       style: TextStyle(
                                      //         color: Color.fromARGB(
                                      //             255, 255, 255, 255),
                                      //         // letterSpacing: 1,
                                      //         fontSize: 13,
                                      //         // fontWeight: FontWeight.w800
                                      //       ),
                                      //     ),
                                      //     duration: Duration(seconds: 3),
                                      //   );

                                      //   // Find the ScaffoldMessenger in the widget tree
                                      //   // and use it to show a SnackBar.
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(snackBar);
                                      // }
                                      else {
                                        final ctln = DateFormat('ddMM-hhmm-sss')
                                            .format(DateTime.now());
                                        final link =
                                            "/incoming_data/incoming_files/${selectedFile!.name.replaceAll('.${selectedFile!.extension}', '')}/${selectedFile!.name}";

                                        createRecord(
                                            partcontroller.text,
                                            agencycontroller.text,
                                            datecontroller.text,
                                            "new",
                                            "",
                                            ctlncontroller.text,
                                            dateReceivedcontroller.text,
                                            link);

                                        uploadFile();

                                        // Navigator.pop(context);

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Home()));

                                        //  html.window.location.reload();
                                        latestController.animateTo(
                                          latestController
                                              .position.maxScrollExtent,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.linear,
                                        );
                                      }

                                      // await  eref.child('Incoming Datas').push().set({
                                      //     "Particulars": partcontroller.text,
                                      //     "Agency": agencycontroller.text,
                                      //     "DateMade": datecontroller.text
                                      //   });

                                      // html.window.location.reload();
                                      //  setState(() {
                                      //    (context as Element).performRebuild();
                                      //  });
                                    },
                                    child: Center(
                                      child: Text("Submit",
                                          style: addtitleFont(context)),
                                    ))
                              ],
                            ),
                          );
                        });
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Add Records",
                    style: bodyFont(context),
                  )),
              NeumorphicButton(
                  margin: EdgeInsets.all(12),
                  onPressed: () {
                    NeumorphicTheme.of(context)!.themeMode =
                        NeumorphicTheme.isUsingDark(context)
                            ? ThemeMode.light
                            : ThemeMode.dark;
                    //Navigator.pushNamed(context, 'home');
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Change Theme",
                    style: bodyFont(context),
                  )),

            ],
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
            title: Hero(
              tag: 'incoming',
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    disableDepth: true,
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Incoming Communications",
                      style: titleFont(context)),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: NeumorphicTheme.baseColor(context),
        extendBodyBehindAppBar: true,
        body: FutureBuilder<List<Model>>(

            future: getRecords(),
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
                                                                              MaterialPageRoute(builder: (BuildContext context) => Home()));
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
                                                              Home()));
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
