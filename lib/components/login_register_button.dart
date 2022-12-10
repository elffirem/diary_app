import 'package:diary_app/base/base_utility.dart';
import 'package:diary_app/base/firebase/auth.dart';
import 'package:diary_app/ui/model/diary_page_model.dart';
import 'package:diary_app/ui/view/calendar_page_view.dart';
import 'package:diary_app/ui/viewmodel/diary_page_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginRegisterButton extends StatefulWidget {
  int type;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  LoginRegisterButton(
      {super.key,
      required this.type,
      required this.nameController,
      required this.emailController,
      required this.passwordController});

  @override
  State<LoginRegisterButton> createState() => _LoginRegisterButtonState();
}

class _LoginRegisterButtonState extends State<LoginRegisterButton> {
  TextFieldModel model = TextFieldModel(350, 50, 1);
  DiaryPageViewmodel viewmodel = DiaryPageViewmodel();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        widget.type == 0 ? registerFunc() : loginFunc();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: ColorUtility.blueGrey,
            borderRadius: BorderRadius.circular(17),
          ),
          height: model.height * 2 / 3,
          width: model.width / 3,
          child: Center(
            child: Text(
              widget.type == 1 ? "LOGIN" : "REGISTER",
              style: const TextStyle(color: ColorUtility.pageColor),
            ),
          )),
    );
  }

  void registerFunc() async {
    if (widget.emailController.text.isNotEmpty &&
        widget.nameController.text.isNotEmpty &&
        widget.passwordController.text.isNotEmpty) {
      if (await FirebaseAuthManager.instance.register(
              name: widget.nameController.text,
              email: widget.emailController.text,
              password: widget.passwordController.text,
              context: context) ==
          1) {
        viewmodel.dataSave(widget.nameController, widget.emailController,
            widget.passwordController);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CalendarPageView()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all blanks correctly")));
    }
  }

  void loginFunc() async {
    print("helo");
    if (widget.emailController.text.isNotEmpty &&
        widget.nameController.text.isNotEmpty &&
        widget.passwordController.text.isNotEmpty) {
      if (await FirebaseAuthManager.instance.login(
              email: widget.emailController.text,
              password: widget.passwordController.text,
              context: context) ==
          1) {
        viewmodel.dataSave(widget.nameController, widget.emailController,
            widget.passwordController);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CalendarPageView()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all blanks correctly")));
    }
  }
}
