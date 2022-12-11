import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageManager {
  static StorageManager? _instance;
  static StorageManager get instance {
    _instance ??= StorageManager._init();
    return _instance!;
  }

  StorageManager._init();

  Future<File?> pickPhoto() async {
    if (await askForPermission()) {
      if (await askForPermission()) {
        XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          String path = image.path;
          return File(path);
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> askForPermission() async {
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
      if (await Permission.storage.isDenied) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
