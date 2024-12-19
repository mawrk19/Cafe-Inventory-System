import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/products_service.dart';

class DeletedProduct extends StatefulWidget {
  const DeletedProduct({Key? key}) : super(key: key);

  @override
  _DeletedProductState createState() => _DeletedProductState();
}

class _DeletedProductState extends State<DeletedProduct> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _archivedProducts;

  @override
  void initState() {
    super.initState();
    _archivedProducts = _firestoreService.getAllArchivedProducts(); // Fetch all archived products
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _archivedProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error fetching archived products: ${snapshot.error}',
              textAlign: TextAlign.center,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No archived products found.'),
          );
        } else {
          var products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(product['name'] ?? 'Unnamed Product'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildButton('Add Again', () {
                        _restoreProduct(product['categoryId'], product['id']);
                      }),
                      const SizedBox(width: 10),
                      _buildButton('Remove', () {
                        _deleteProduct(product['categoryId'], product['id']);
                      }),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _restoreProduct(String categoryId, String productId) async {
    try {
      await _firestoreService.editProduct(categoryId, productId, {'status': 'active'});
      setState(() {
        _archivedProducts = _firestoreService.getAllArchivedProducts();
      });
    } catch (e) {
      _showErrorDialog('Failed to restore product: $e');
    }
  }

  void _deleteProduct(String categoryId, String productId) async {
    try {
      await _firestoreService.deleteProduct(categoryId, productId);
      setState(() {
        _archivedProducts = _firestoreService.getAllArchivedProducts();
      });
    } catch (e) {
      _showErrorDialog('Failed to delete product: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Helper method for building buttons
  Widget _buildButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF3B2117),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFFFFF4E6),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.12,
          ),
        ),
      ),
    );
  }
}
