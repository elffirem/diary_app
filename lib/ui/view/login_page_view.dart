import 'package:diary_app/base/base_utility.dart';
import 'package:diary_app/base/firebase/auth.dart';
import 'package:diary_app/ui/model/diary_page_model.dart';
import 'package:diary_app/ui/view/calendar_page_view.dart';
import 'package:flutter/material.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextFieldModel model = TextFieldModel(350, 50, 1);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String login = "♡ Welcome ♡";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.backGroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              login,
              style: TextStyleUtility.diaryHeadlineStyle.copyWith(
                color: ColorUtility.blueGrey,
              ),
            ),
            const SizedBox(height: 30),
            buildNameTextField(nameController, "Your name"),
            const SizedBox(height: 20),
            buildNameTextField(emailController, "E-mail"),
            const SizedBox(height: 20),
            buildNameTextField(passwordController, "Password"),
            const SizedBox(height: 20),
            loginButton(nameController, emailController, passwordController)
          ],
        ),
      ),
    );
  }

  Widget loginButton(
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return InkWell(
      onTap: () async {
        if (emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          if (await FirebaseAuthManager.instance.register(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  context: context) ==
              1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CalendarPageView()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please fill all blanks correctly")));
        }
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: ColorUtility.blueGrey,
            borderRadius: BorderRadius.circular(17),
          ),
          height: model.height * 2 / 3,
          width: model.width / 3,
          child: const Center(
            child: Text(
              "LOGIN",
              style: TextStyle(color: ColorUtility.pageColor),
            ),
          )),
    );
  }

  Container buildNameTextField(TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ColorUtility.pageColor,
        borderRadius: BorderRadius.circular(17),
      ),
      height: model.height,
      width: model.width,
      child: TextField(
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }
}
