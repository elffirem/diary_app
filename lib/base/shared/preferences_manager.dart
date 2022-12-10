import 'package:shared_preferences/shared_preferences.dart';

//taqanarslan
class PreferencesManager {
  SharedPreferences? storage;
  static PreferencesManager? _instance;
  static PreferencesManager get instance {
    _instance ??= PreferencesManager._init();
    return _instance!;
  }

  PreferencesManager._init();

  Future<void> initPref() async {
    storage = await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    storage!.setString(key, value);
  }

  getString(String key) {
    return storage!.getString(key);
  }
}
