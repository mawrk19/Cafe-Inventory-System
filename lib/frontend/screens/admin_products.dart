import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/firestore.dart';
import 'package:kopilism/frontend/widgets/add_product.dart'; // Import the AddProductModal

class AdminProducts extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const AdminProducts({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

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

  Future<void> _fetchProducts() async {
    final products = await _firestoreService.getProductsByCategory(widget.categoryId);
    setState(() {
      _products = products;
    });
  }

  void _showAddProductModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductModal(
          categoryId: widget.categoryId,
          onProductAdded: _fetchProducts,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products in ${widget.categoryName}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductModal(context);
        },
        child: const Icon(Icons.add),
      ),
      body: _products.isEmpty
          ? const Center(child: Text('No products available'))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product['name'] ?? 'Unnamed Product'),
                  subtitle: Text('\$${product['price'] ?? '0.00'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _firestoreService.deleteProduct(widget.categoryId, product['id']);
                      _fetchProducts();
                    },
                  ),
                  onTap: () {
                    // Handle product edit if needed
                  },
                );
              },
            ),
    );
  }
}
