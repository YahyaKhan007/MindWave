import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class AudioPickerUtils {
  Future<List<dynamic>?> pickAudio() async {
    List<dynamic> pickedFile = [];
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path!);

        String fileName = result.files.single.name;

        log('=============> $fileName');

        // String fileName = result.files.single.name;

        pickedFile.add(file);
        pickedFile.add(fileName);

        log('\n\n\t===========>\t\tList indexes result');
        log('=============> ${pickedFile[0].toString()}');
        log('=============> ${pickedFile[1].toString()}');

        // Handle the selected audio file (file variable contains the picked audio file)
        // log("Picked audio file: ${file.path}");
        return pickedFile;
      } else {
        // User canceled the file picking
        log("File picking canceled");
      }

      return pickedFile;
    } catch (e) {
      log("Error picking audio file: $e");
      return null;
    }
  }
}
