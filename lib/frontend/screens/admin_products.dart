import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/firestore_service.dart';
import 'package:kopilism/frontend/widgets/product_card.dart'; // Updated import
import 'package:kopilism/frontend/widgets/add_product.dart'; // Import the AddProductModal

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

  // Fetch products using the categoryId
  Future<void> _fetchProducts() async {
    final products = await _firestoreService.getProductsByCategory(widget.categoryId);
    if (mounted) {
      setState(() {
        _products = products;
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
                return AdminProductCard(
                  productId: product['id'],
                  categoryId: widget.categoryId,  // Pass categoryId here
                  productName: product['name'] ?? 'Unnamed Product',
                  productImage: product['image'] ?? 'assets/images/ProductPhoto.png',  // Use 'image' field
                  productQuantity: product['stockQuantity'] ?? 0,
                  productPrice: product['price'] ?? 0.0,
                );
              },
            ),
    );
  }
}
