import 'package:diary_app/base/base_utility.dart';
import 'package:diary_app/components/login_register_button.dart';
import 'package:diary_app/ui/model/diary_page_model.dart';
import 'package:diary_app/ui/view/login_page_view.dart';
import 'package:flutter/material.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({super.key});

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  TextFieldModel model = TextFieldModel(350, 50, 1);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String register = "♡ You Can Register Now ♡";
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
              register,
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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: TextButton(
                    child: Text(
                      "Do you already have an account?",
                      style: TextStyleUtility.pageHeadlineStyle
                          .copyWith(color: ColorUtility.blueGrey, fontSize: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPageView()),
                      );
                    }),
              ),
            ),
            const SizedBox(height: 20),
            LoginRegisterButton(
                type: 0,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController)
          ],
        ),
      ),
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
