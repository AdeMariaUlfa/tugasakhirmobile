import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('departement');

class Departement {
  static String userUid;

  static Future<void> addDept({
    String id,
    String namaDept,
    String tempat,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('departements').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "namaDept": namaDept,
      "tempat": tempat,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateDept({
    String id,
    String namaDept,
    String tempat,
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('departements').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "namaDept": namaDept,
      "tempat": tempat,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readDept() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('departements');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteDept({
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('departements').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
