import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storgae;

class Storage {
  final firebase_storgae.FirebaseStorage storage =
      firebase_storgae.FirebaseStorage.instance;

  Future<firebase_storgae.ListResult> listFiles() async {
    firebase_storgae.ListResult result = await storage.ref('files').listAll();

    result.items.forEach((firebase_storgae.Reference ref) {
      print('Found file : $ref');
    });

    return result;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('files/$imageName').getDownloadURL();

    return downloadURL;
  }
}
