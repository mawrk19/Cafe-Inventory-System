import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/firestore_service.dart';
import 'package:kopilism/frontend/widgets/products/product_card.dart'; // Updated import

class EmployeeProducts extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const EmployeeProducts({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<EmployeeProducts> createState() => _EmployeeProductsState();
}

class _EmployeeProductsState extends State<EmployeeProducts> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products in ${widget.categoryName}'), // Display category name
      ),
      // Removed floatingActionButton
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
