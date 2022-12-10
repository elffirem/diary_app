import 'package:diary_app/base/base_utility.dart';
import 'package:diary_app/base/firebase/auth.dart';
import 'package:diary_app/base/firebase/firestore.dart';
import 'package:diary_app/components/save_button.dart';
import 'package:diary_app/ui/model/diary_page_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryPageView extends StatefulWidget {
  DateTime date;
  DiaryPageView({super.key, required this.date});

  @override
  State<DiaryPageView> createState() => _DiaryPageViewState();
}

class _DiaryPageViewState extends State<DiaryPageView> {
  bool isEmpty = true;
  String formattedDate = "";
  @override
  void initState() {
    formattedDate = dateFormat.format(widget.date);
    FirestoreManager.instance
        .firestoreGetDocumentInDocument(
            collectionID: "user",
            collectionID2: "diaries",
            docID: FirebaseAuthManager.userData["userID"],
            docID2: formattedDate)
        .then((value) {
      if (value != null) {
        isEmpty = false;
        Map text = value as Map;
        diaryText.text = text["diaryText"];
      } else {}
    });
    super.initState();
  }

  DateFormat dateFormat = DateFormat("dd.MM.yyyy");
  TextEditingController diaryText = TextEditingController();
  TextFieldModel model = TextFieldModel(285, 405, 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.backGroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
              child: Stack(
                children: [
                  mainContainer(context, formattedDate),
                  backGroundImage(context),
                  buildText(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Button(
                  onTap: () async {
                    if (isEmpty == true) {
                      await FirestoreManager.instance.firestoreSetDocInDocAsMap(
                          collectionID: "user",
                          collectionID2: "diaries",
                          docID: FirebaseAuthManager.userData["userID"],
                          docID2: formattedDate,
                          data: {"diaryText": diaryText.text});
                    } else {
                      await FirestoreManager.instance
                          .firestoreUpdateDocInDocAsMap(
                              collectionID: "user",
                              collectionID2: "diaries",
                              docID: FirebaseAuthManager.userData["userID"],
                              docID2: formattedDate,
                              data: {"diaryText": diaryText.text});
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container mainContainer(BuildContext context, String formattedDate) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 4,
      width: MediaQuery.of(context).size.width * 4 / 5,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: ColorUtility.blueGrey),
        borderRadius: BorderRadius.circular(17),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            date(formattedDate),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Align date(String formattedDate) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 20),
        child: Text(
          formattedDate.toString(),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Padding buildText() {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 35),
      child: SizedBox(
        height: model.height,
        width: model.width,
        child: TextField(
          maxLines: model.maxLines,
          controller: diaryText,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Dear diary...',
          ),
        ),
      ),
    );
  }

  Opacity backGroundImage(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        height: MediaQuery.of(context).size.height * 3 / 4,
        width: MediaQuery.of(context).size.width * 4 / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.white,
          image: const DecorationImage(
              image: AssetImage(
                "assets/images/heart.jpg",
              ),
              fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
