import 'package:diary_app/base/services/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//taqanarslan
class FirebaseAuthManager {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseAuthManager? _instance;

  static FirebaseAuthManager get instance {
    _instance ??= FirebaseAuthManager._init();
    return _instance!;
  }

  FirebaseAuthManager._init();

  static UserCredential? authedUser;
  static dynamic userData;
  Future<int> login(
      {required String email,
      required String password,
      BuildContext? context}) async {
    try {
      authedUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (authedUser != null) {
        userData = await FirestoreManager.instance.firestoreGetDocument(
            collectionID: "user", documentID: authedUser!.user!.uid);
        return 1;
      } else {
        return 0;
      }
    } on FirebaseAuthException catch (e) {
      if (context != null) {
        switch (e.code) {
          case "user-not-found":
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Girdiğiniz Mail Kayıtlı Değil"),
                backgroundColor: Color(0xFF73BAA1)));
            break;
          case "wrong-password":
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Girdiğiniz Şifre Yanlış"),
                backgroundColor: Color(0xFF73BAA1)));
            break;
          case "unknown":
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Lütfen Alanları Doldurduğunuzdan Emin Olun"),
                backgroundColor: Color(0xFF73BAA1)));
            break;
          case "invalid-email":
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Lütfen Geçerli Bir Mail Adresi Girin"),
                backgroundColor: Color(0xFF73BAA1)));
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.message.toString()),
                backgroundColor: const Color(0xFF73BAA1)));
        }
      }
      return -1;
    }
  }

  Future<int> register(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        await FirestoreManager.instance.firestoreSendDataMap(
          collectionID: 'user',
          docID: user.user!.uid,
          data: {
            'name': name,
            'email': email,
            'userID': user.user!.uid,
            'created': DateTime.now()
          },
        );
        await FirestoreManager.instance.firestoreCreateCollectionInDoc(
            collectionID: "user",
            collectionID2: "diaries",
            docID: user.user!.uid,
            data: {"asd": "asd"});
        authedUser = user;
        userData = await FirestoreManager.instance.firestoreGetDocument(
            collectionID: "user", documentID: authedUser!.user!.uid);

        return 1;
      } else {
        return 0;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      return -1;
    }
  }
}
