import 'package:diary_app/base/services/shared/preferences_manager.dart';
import 'package:diary_app/ui/model/diary_page_model.dart';

class DiaryPageViewmodel {
  TextFieldModel model = TextFieldModel(350, 50, 1);
  void dataSave(String name, String email, String password) {
    PreferencesManager.instance.setString("name", name);
    PreferencesManager.instance.setString("email", email);
    PreferencesManager.instance.setString("password", password);
  }
}
