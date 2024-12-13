import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Category CRUD Operations
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

  // Product CRUD Operations

  // Add a product
  Future<void> addProduct(String categoryId, String productId, Map<String, dynamic> data) async {
    await _db.collection('categories').doc(categoryId).collection('products').doc(productId).set(data);
  }

  // Get a product by ID
  Future<Map<String, dynamic>?> getProductById(String productId) async {
    DocumentSnapshot snapshot = await _db.collection('products').doc(productId).get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    }
    return null; // Return null if the product doesn't exist
  }

  // Get all products
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    QuerySnapshot snapshot = await _db.collection('products').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // Get products by category
  Future<List<Map<String, dynamic>>> getProductsByCategory(String categoryId) async {
    QuerySnapshot snapshot = await _db
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // Edit a product
  Future<void> editProduct(String productId, Map<String, dynamic> data) async {
    final categorySnapshot = await _db.collection('categories').get();
    for (var category in categorySnapshot.docs) {
      final productSnapshot = await category.reference.collection('products').doc(productId).get();
      if (productSnapshot.exists) {
        await productSnapshot.reference.update(data);
        break;
      }
    }
  }

  // Delete a product
  Future<void> deleteProduct(String categoryId, String productId) async {
    await _db.collection('categories').doc(categoryId).collection('products').doc(productId).delete();
  }

  // Helper function to set default image if none is provided
  String getImageUrl(String? imageUrl) {
    return imageUrl ?? 'assets/images/ProductPhoto.png'; // Default image if no URL is provided
  }
}
