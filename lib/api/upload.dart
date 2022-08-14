
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
PlatformFile? selectedFile;


Future pickFile() async {

FilePickerResult? result = await FilePicker.platform.pickFiles();

selectedFile = result!.files.first;


return selectedFile;
}


Future uploadFile() async {
  PlatformFile selectedFile1 = await pickFile();
  
final bytes = selectedFile1.bytes as Uint8List;



}