import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kopilism/backend/services/products_service.dart';
import 'package:kopilism/frontend/widgets/products/product_card.dart'; // Updated import
import 'package:kopilism/frontend/widgets/products/add_product.dart'; // Import the AddProductModal
import 'package:kopilism/frontend/widgets/products/edit_product.dart'; // Import the EditProductModal
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import for notifications

class AdminProducts extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const AdminProducts({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<AdminProducts> createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // Fetch products using the categoryId and filter by status 'available'
  Future<void> _fetchProducts() async {
    final products = await _firestoreService.getProductsByCategory(widget.categoryId);
    if (mounted) {
      setState(() {
        _products = products.where((product) => product['status'] == 'available').toList();
      });
    }
  }

  // Show AddProductModal to add a new product
  void _showAddProductModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductModal(
          categoryId: widget.categoryId,  // Pass categoryId to modal
          onProductAdded: _fetchProducts,  // Refresh product list after adding
        );
      },
    );
  }

  // Show sliding up panel with options
  void _showProductOptions(BuildContext context, Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _showEditProductModal(context, product);
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archive'),
              onTap: () async {
                Navigator.pop(context);
                await _archiveProduct(product['id']);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _archiveProduct(String productId) async {
    await _firestoreService.updateProduct(widget.categoryId, productId, {'status': 'archived'});
    _fetchProducts();
    Fluttertoast.showToast(msg: 'Product archived successfully');
    _createNotification('Archive', 'Product archived successfully');
  }

  Future<void> _createNotification(String header, String message) async {
    await FirebaseFirestore.instance.collection('notifications').doc('users').collection('admin').add({
      'header': header,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
    });
  }

  // Show EditProductModal to edit a product
  void _showEditProductModal(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditProductModal(
          product: product,
          onProductEdited: () async {
            await _fetchProducts();
            _createNotification('Update', 'Product updated successfully');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products in ${widget.categoryName}'), // Display category name
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductModal(context); // Show the modal when pressed
        },
        child: const Icon(Icons.add),
      ),
      body: _products.isEmpty
          ? const Center(child: Text('No products available')) // Show message if no products
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return GestureDetector(
                  onLongPress: () {
                    _showProductOptions(context, product); // Show options on long press
                  },
                  child: AdminProductCard(
                    productId: product['id'],
                    categoryId: widget.categoryId,  // Pass categoryId here
                    productName: product['name'] ?? 'Unnamed Product',
                    productImage: product['image'] ?? 'assets/images/ProductPhoto.png',  // Use 'image' field
                    productQuantity: product['stockQuantity'] ?? 0,
                    productPrice: product['price'] ?? 0.0,
                  ),
                );
              },
            ),
    );
  }
}
