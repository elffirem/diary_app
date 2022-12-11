import 'package:diary_app/base/base_utility.dart';
import 'package:diary_app/ui/viewmodel/diary_page_viewmodel.dart';
import 'package:flutter/material.dart';

class DiaryButton extends StatefulWidget {
  final Function() onTap;
  final String title;
  const DiaryButton({super.key, required this.onTap, required this.title});

  @override
  State<DiaryButton> createState() => _DiaryButtonState();
}

class _DiaryButtonState extends State<DiaryButton> {
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
          height: viewmodel.model.height * 3 / 4,
          width: viewmodel.model.width / 4,
          child: Center(
            child: Text(
              widget.title,
              style: const TextStyle(color: ColorUtility.pageColor),
            ),
          )),
    );
  }
}
