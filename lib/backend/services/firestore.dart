import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // create a category
  Future<void> addCategory(String id, Map<String, dynamic> data) async {
    await _db.collection('categories').doc(id).set(data);
  }

  // get all categories
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    QuerySnapshot snapshot = await _db.collection('categories').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // edit a category
  Future<void> editCategory(String id, Map<String, dynamic> data) async {
    await _db.collection('categories').doc(id).update(data);
  }

  // delete a category
  Future<void> deleteCategory(String id) async {
    await _db.collection('categories').doc(id).delete();
  }
}