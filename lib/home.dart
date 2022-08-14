// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neomorph/designs/style.dart';

import 'api/config.dart';
import 'api/get.dart';
import 'models/Model.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

final ip = Config.Server;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Model>> futureModels;

  TextEditingController partcontroller = TextEditingController();
  TextEditingController agencycontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController statuscontroller = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();
  bool changeColor = false;

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
    futureModels = getRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: AppBar(
            actions: [
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
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    padding: const EdgeInsets.all(12.0),
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
                            child: Text('',
                            style: subtitleFont(context),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Text('CONTROL NO.',
                             style: subtitleFont(context),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: Center(child: Text('DATE RECEIVED',
                             style: subtitleFont(context),
                            ))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Center(child: Text('PARTICULARS',
                             style: subtitleFont(context),))),
                        // DataColumn(label: Text('OTM CONTROL NO.')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text('AGENCY//OFFICE FROM',
                             style: subtitleFont(context),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                            child: Text('DATE MADE',
                             style: subtitleFont(context),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Center(child: Text('Remarks',
                             style: subtitleFont(context),
                            ))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                            child: Text('',
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
                  child:
                      Text("Incoming Communications", style: titleFont(context)),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: NeumorphicTheme.baseColor(context),
        extendBodyBehindAppBar: true,
        body: FutureBuilder<List<Model>>(
            future: futureModels,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
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
                                        child: Text(
                                          "${index + 1}",
                                          style: bodyFont(context)
                                        ),
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
                                              style: bodyFont(context)
                                            ),
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
                                                style: TextButton.styleFrom(
                                                    // primary: changeColor ? Colors.blue : Colors.pink,
                                                    //primary: Colors.blue,
                                                    // onSurface: Colors.green,
                                                    ),
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
                
                                                  html.window.open('${url}',
                                                      '${snapshot.data![index].particulars}');
                
                                                  /////////////////////////////////////
                
                                                  //////////////////////////////////////////
                                                },
                                                child: Tooltip(
                                                    message:
                                                        "Click to Download the file",
                                                    child: Text(
                                                        "${snapshot.data![index].particulars}",
                                                        style: bodyFont(context)))),
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
                                                0.1,
                                            child: Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: ((BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Row(
                                                              children: [
                                                                const Text(
                                                                    'Status: '),
                                                                Text(
                                                                  '${snapshot.data![index].status}',
                                                                  style: TextStyle(
                                                                      color: snapshot.data![index].status == 'terminated'
                                                                          ? const Color.fromARGB(255, 240, 28, 28)
                                                                          : snapshot.data![index].status == 'accomplished'
                                                                              ? const Color.fromARGB(255, 35, 240, 28)
                                                                              : snapshot.data![index].status == 'new'
                                                                                  ? const Color.fromARGB(255, 10, 151, 153)
                                                                                  : const Color.fromARGB(255, 240, 226, 28)),
                                                                ),
                                                              ],
                                                            ),
                                                            content: SizedBox(
                                                              width: 200,
                                                              height: 200,
                                                              child: Text(
                                                                  '${snapshot.data![index].remarks}'),
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
                                                    style: bodyFont(context)),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: ((BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Edit Status'),
                                                              content: SizedBox(
                                                                height: 150,
                                                                width: 100,
                                                                child: Column(
                                                                  children: [
                                                                    TextFormField(
                                                                      controller:
                                                                          statuscontroller,
                                                                      decoration: const InputDecoration(
                                                                          hintText:
                                                                              'Status'),
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return ("This field shouldn't be empty");
                                                                        }
                                                                      },
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          remarkscontroller,
                                                                      decoration: const InputDecoration(
                                                                          hintText:
                                                                              'Remarks'),
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return ("This field shouldn't be empty");
                                                                        }
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
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
                                                                      // Navigator.of(
                                                                      //         context)
                                                                      //     .pushReplacement(
                                                                      //         MaterialPageRoute(
                                                                      //             builder:
                                                                      //                 (BuildContext context) =>
                                                                      //                     Try()));
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            "Save"))
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
                                                    icon: const Icon(Icons.edit))
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
                                                  // dref.child('${keys[index]}').remove();
                                                  // sref
                                                  //     .child(
                                                  //         'files/${snapshot.data![index].part}.${snapshot.data![index].ext}')
                                                  //     .delete();
                
                                                  const snackBar = SnackBar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 210, 111, 36),
                                                    content: Text(
                                                        'Successfully Deleted'),
                                                    duration:
                                                        Duration(seconds: 3),
                                                  );
                
                                                  // Find the ScaffoldMessenger in the widget tree
                                                  // and use it to show a SnackBar.
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                
                                                  const CircularProgressIndicator();
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          maintainState: false,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const Home()));
                                                },
                                                icon: const Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.redAccent,
                                                  size: 30,
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

              return const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            })),
      ),
    );
  }
}