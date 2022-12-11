import 'package:cloud_firestore/cloud_firestore.dart';

//taqanarslan
class FirestoreManager {
  static FirestoreManager? _instance;
  static FirestoreManager get instance {
    _instance ??= FirestoreManager._init();
    return _instance!;
  }

  FirestoreManager._init();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> firestoreDeleteDoc(
      {required String collectionID, required String docID}) async {
    await _firebaseFirestore.collection(collectionID).doc(docID).delete();
  }

  Future<bool> firestoreCheckDoc(
      {required String collectionID, required String docID}) async {
    bool exists = false;
    await FirebaseFirestore.instance
        .collection(collectionID)
        .doc(docID)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          exists = true;
        }
      },
    );
    return exists;
  }

  Future<void> firestoreSendDataMap(
      {required String collectionID,
      required String docID,
      required Map<String, dynamic> data}) async {
    await _firebaseFirestore.collection(collectionID).doc(docID).set(data);
  }

  Future<String> firestoreCreateNewDoc(
      {required String collectionID,
      required Map<String, dynamic> data}) async {
    var ref = await _firebaseFirestore.collection(collectionID).add(data);
    return ref.id;
  }

  CollectionReference firestoreGetColectionRef({required String collectionID}) {
    CollectionReference collectionRef =
        _firebaseFirestore.collection(collectionID);
    return collectionRef;
  }

  Future firestoreDeleteField(
      {required String collectionID,
      required String docID,
      required String fieldID}) async {
    await _firebaseFirestore
        .collection(collectionID)
        .doc(docID)
        .update({fieldID: FieldValue.delete()});
  }

  Future<List> firestoreGetCollection({required String collectionID}) async {
    CollectionReference collectionRef =
        _firebaseFirestore.collection(collectionID);
    QuerySnapshot collection = await collectionRef.get();
    List documents = collection.docs.map((doc) => doc.data()).toList();
    return documents;
  }

  DocumentReference firestoreGetDocumentRef(
      {required String collectionID, required String documentID}) {
    DocumentReference documentReference =
        _firebaseFirestore.collection(collectionID).doc(documentID);
    return documentReference;
  }

  Future<Object?> firestoreGetDocument(
      {required String collectionID, required String documentID}) async {
    DocumentReference documentRef =
        _firebaseFirestore.collection(collectionID).doc(documentID);
    DocumentSnapshot document = await documentRef.get();
    Object? data = document.data();
    return data;
  }

  Future<void> firestoreUpdateAsDynamic(
      {required String collectionID,
      required String docID,
      required String dataName,
      required dynamic data}) async {
    await _firebaseFirestore
        .collection(collectionID)
        .doc(docID)
        .update({dataName: data});
  }

  Future<void> firestoreUpdateAsMap(
      {required String collectionID,
      required String docID,
      required Map<String, dynamic> data}) async {
    await _firebaseFirestore.collection(collectionID).doc(docID).update(data);
  }

  Future<String> firestoreCreateCollectionInDoc(
      {required String collectionID,
      required String collectionID2,
      required String docID,
      required Map<String, dynamic> data}) async {
    var ref = await _firebaseFirestore
        .collection(collectionID)
        .doc(docID)
        .collection(collectionID2)
        .add(data);
    return ref.id;
  }

  Future<void> firestoreUpdateDocInDocAsMap(
      {required String collectionID,
      required String collectionID2,
      required String docID,
      required String docID2,
      required Map<String, dynamic> data}) async {
    await _firebaseFirestore
        .collection(collectionID)
        .doc(docID)
        .collection(collectionID2)
        .doc(docID2)
        .update(data);
  }

  Future<void> firestoreSetDocInDocAsMap(
      {required String collectionID,
      required String collectionID2,
      required String docID,
      required String docID2,
      required Map<String, dynamic> data}) async {
    await _firebaseFirestore
        .collection(collectionID)
        .doc(docID)
        .collection(collectionID2)
        .doc(docID2)
        .set(data);
  }

  Future<Object?> firestoreGetDocumentInDocument(
      {required String collectionID,
      required String collectionID2,
      required String docID,
      required String docID2}) async {
    DocumentReference documentRef = _firebaseFirestore
        .collection(collectionID)
        .doc(docID)
        .collection(collectionID2)
        .doc(docID2);
    DocumentSnapshot document = await documentRef.get();
    Object? data = document.data();
    return data;
  }

  CollectionReference firestoreGetColectionRefInDoc({
    required String collectionID,
    required String collectionID2,
    required String docID,
  }) {
    CollectionReference collectionRef = _firebaseFirestore
        .collection(collectionID)
        .doc(docID)
        .collection(collectionID2);
    return collectionRef;
  }

  Future firestoreDeleteCollectionInDoc(
      {required String collectionID,
      required String collectionID2,
      required String docID,
      required String docID2}) async {
    await _firebaseFirestore
        .collection(collectionID)
        .doc(docID)
        .collection(collectionID2)
        .doc(docID2)
        .delete();
  }
}
