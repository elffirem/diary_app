import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

//taqanarslan
class FirebaseStorageManager {
  String bucket = "gs://yagmurunelindenapp-951db.appspot.com";
  static FirebaseStorageManager? _instance;
  static FirebaseStorageManager get instance {
    _instance ??= FirebaseStorageManager._init();
    return _instance!;
  }

  FirebaseStorageManager._init();

  Future<String> getDownloadLink(String path) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageUrl = await storageRef.child(path).getDownloadURL();
    return imageUrl;
  }

  Future deleteItem(String path) async {
    final fileRef = FirebaseStorage.instance.ref(path);
    fileRef.delete();
  }

  Future uploadFile(String destination, File file) async {
    try {
      final fileRef = FirebaseStorage.instance.ref(destination);
      await fileRef.putFile(file);
      return true;
    } on FirebaseException {}
  }
}
