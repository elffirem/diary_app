
import 'package:flutter/material.dart';

class DiaryShowPhotosView extends StatefulWidget {
  String date;
  int photoNumber;
  List<String> urlList;
  DiaryShowPhotosView({super.key, required this.photoNumber, required this.date, required this.urlList});

  @override
  State<DiaryShowPhotosView> createState() => _DiaryShowPhotosViewState();
}

class _DiaryShowPhotosViewState extends State<DiaryShowPhotosView> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        for (int i = 0; i < widget.photoNumber; i++) {}
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(widget.photoNumber, (index) {
              return Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Image.network(widget.urlList[index]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
