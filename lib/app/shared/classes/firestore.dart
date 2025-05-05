import 'package:cloud_firestore/cloud_firestore.dart';

class FIRESTORE {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> post(
      String collection, String docId, Map<String, dynamic> data) async {
    await firestore.collection(collection).doc(docId).set(data);
  }

  static Future<Map<String, dynamic>> read(
      String collection, String docId) async {
    DocumentSnapshot doc =
        await firestore.collection(collection).doc(docId).get();

    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  static Future<void> update(
      String collection, String docId, Map<String, dynamic> data) async {
    await firestore.collection(collection).doc(docId).update(data);
  }

  static Future<void> delete(
      String collection, String docId, Map<String, dynamic> data) async {
    await firestore.collection(collection).doc(docId).get();
  }
}


// {
//       'name': name,
//       'age': age,
//       'email': email,
//     }