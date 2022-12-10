import 'package:diary_app/base/base_utility.dart';
import 'package:diary_app/ui/viewmodel/diary_page_viewmodel.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function() onTap;
  const Button({super.key, required this.onTap});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  DiaryPageViewmodel viewmodel = DiaryPageViewmodel();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: ColorUtility.blueGrey,
            borderRadius: BorderRadius.circular(17),
          ),
          height: viewmodel.model.height * 1 / 2,
          width: viewmodel.model.width / 4,
          child: const Center(
            child: Text(
              "SAVE",
              style: TextStyle(color: ColorUtility.pageColor),
            ),
          )),
    );
  }
}
