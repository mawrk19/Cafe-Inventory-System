import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Category CRUD Operations ---

  // Create a category
  Future<void> addCategory(String id, Map<String, dynamic> data) async {
    try {
      await _db.collection('categories').doc(id).set(data);
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  // Get all categories
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      QuerySnapshot snapshot = await _db.collection('categories').get();
      return snapshot.docs.map((doc) {
        return {
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id, // Add document ID for easy reference
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  // Get archived categories
  Future<List<Map<String, dynamic>>> getArchivedCategories() async {
    try {
      QuerySnapshot snapshot = await _db.collection('categories').where('status', isEqualTo: 'archived').get();
      return snapshot.docs.map((doc) {
        return {
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id, // Add document ID for easy reference
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch archived categories: $e');
    }
  }

  // Edit a category
  Future<void> editCategory(String id, Map<String, dynamic> data) async {
    try {
      await _db.collection('categories').doc(id).update(data);
    } catch (e) {
      throw Exception('Failed to edit category: $e');
    }
  }

  // Update a category
  Future<void> updateCategory(String id, Map<String, dynamic> data) async {
    try {
      await _db.collection('categories').doc(id).update(data);
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  // Delete a category
  Future<void> deleteCategory(String id) async {
    try {
      await _db.collection('categories').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }

  // Archive a category
  Future<void> archiveCategory(String categoryId) async {
    try {
      await _db.collection('categories').doc(categoryId).update({'status': 'archived'});
    } catch (e) {
      throw Exception('Failed to archive category: $e');
    }
  }

  // --- Product CRUD Operations ---

  // Add a product
  Future<void> addProduct(String categoryId, String productId, Map<String, dynamic> data) async {
    try {
      await _db.collection('categories')
      .doc(categoryId)
      .collection('products')
      .doc(productId)
      .set(data);
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  //Set SKU to a product
  Future<void> setSku(String categoryId, String productId, Map<String, dynamic> data, String sku) async {     
  try {       
    data['sku'] = sku;

    await _db.collection('categories')       
    .doc(categoryId)       
    .collection('products')       
    .doc(productId)       
    .set(data);     
  } catch (e) {       
    throw Exception('Failed to add product: $e');     
  }   
}

  // Get a product by ID
  Future<Map<String, dynamic>?> getProductById(String categoryId, String productId) async {
    try {
      DocumentSnapshot snapshot = await _db
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .doc(productId)
          .get();

      if (snapshot.exists) {
        return {
          ...snapshot.data() as Map<String, dynamic>,
          'id': snapshot.id, // Add product ID for easy reference
        };
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  // Get products by category
  Future<List<Map<String, dynamic>>> getProductsByCategory(String categoryId) async {
    try {
      QuerySnapshot snapshot = await _db.collection('categories').doc(categoryId).collection('products').get();
      return snapshot.docs.map((doc) {
        return {
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id, // Add product ID for easy reference
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch products for category $categoryId: $e');
    }
  }

  // Edit a product
  Future<void> editProduct(String categoryId, String productId, Map<String, dynamic> data) async {
    try {
      await _db.collection('categories').doc(categoryId).collection('products').doc(productId).update(data);
    } catch (e) {
      throw Exception('Failed to edit product: $e');
    }
  }

  // Delete a product
  Future<void> deleteProduct(String categoryId, String productId) async {
    try {
      await _db.collection('categories').doc(categoryId).collection('products').doc(productId).delete();
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  // Archive a product
  Future<void> archiveProduct(String categoryId, String productId) async {
    try {
      await _db.collection('categories')
        .doc(categoryId)
        .collection('products')
        .doc(productId)
        .update({'status': 'archived'});
    } catch (e) {
      throw Exception('Failed to archive product: $e');
    }
  }

  // --- Helper Functions ---

  // Provide a default image if none is provided
  String getImageUrl(String? imageUrl) {
    return imageUrl ?? 'assets/images/ProductPhoto.png'; // Default image if no URL is provided
  }

  
}
