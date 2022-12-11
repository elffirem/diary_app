import 'package:diary_app/base/services/firebase/storage.dart';
import 'package:flutter/material.dart';
import '../../base/services/firebase/auth.dart';
import '../../base/services/firebase/firestore.dart';

class DiaryShowPhotosView extends StatefulWidget {
  String date;
  int photoNumber;
  DiaryShowPhotosView({super.key, required this.photoNumber, required this.date});

  @override
  State<DiaryShowPhotosView> createState() => _DiaryShowPhotosViewState();
}

class _DiaryShowPhotosViewState extends State<DiaryShowPhotosView> {
  List<String> urlList = [];
  @override
  void initState() {
    for (int i = 0; i < widget.photoNumber; i++) {
      FirebaseStorageManager.instance.getDownloadLink("/${FirebaseAuthManager.userData["userID"]}/photos/${widget.date}/$i").then((value) => urlList.add(value));
    }
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
                child: Image.network(urlList[index]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
