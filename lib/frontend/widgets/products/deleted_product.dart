import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/products_service.dart';

class DeletedProduct extends StatefulWidget {
  const DeletedProduct({super.key});

  @override
  _DeletedProductState createState() => _DeletedProductState();
}

class _DeletedProductState extends State<DeletedProduct> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _archivedProducts;

  @override
  void initState() {
    super.initState();
    _archivedProducts = _firestoreService.getArchivedCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _archivedProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No archived products found.'));
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
                      _buildButton('Add again', () {
                        _firestoreService.updateCategory(product['id'], {'status': 'active'});
                      }),
                      const SizedBox(width: 10),
                      _buildButton('Remove', () {
                        _firestoreService.deleteCategory(product['id']);
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