import 'package:diary_app/ui/model/diary_page_model.dart';
import 'package:flutter/cupertino.dart';

class DiaryPageViewmodel {
  TextFieldModel model = TextFieldModel(350, 50, 1);
  var localStorage;
  void dataSave(TextEditingController name, TextEditingController email,
      TextEditingController password) {
    localStorage.setString("name", name.text);
    localStorage.setString("email", email.text);
    localStorage.setString("password", password.text);
  }
}
