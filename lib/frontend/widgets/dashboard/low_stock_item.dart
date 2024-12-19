import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/products_service.dart';
import 'package:kopilism/frontend/screens/admin/products/admin_product_details.dart'; // Import the product details screen

class LowStockItems extends StatelessWidget {
  const LowStockItems({super.key});

  Future<List<Map<String, dynamic>>> _fetchLowStockItems() async {
    FirestoreService firestoreService = FirestoreService();
    List<Map<String, dynamic>> lowStockItems = [];

    // Assuming you have a method to get all categories
    List<Map<String, dynamic>> categories = await firestoreService.getAllCategories();
    for (var category in categories) {
      List<Map<String, dynamic>> products = await firestoreService.getProductsByCategory(category['id']);
      for (var product in products) {
        if (product['stockQuantity'] < 50) {
          lowStockItems.add(product);
        }
      }
    }
    return lowStockItems;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth * 0.06;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchLowStockItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No low stock items found.');
        } else {
          return Container(
            padding: EdgeInsets.fromLTRB(padding, 32, padding, 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E6),
              borderRadius: BorderRadius.circular(33),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: snapshot.data!.map((product) {
                return Column(
                  children: [
                    _buildItemCard(
                      context: context,
                      categoryId: product['categoryId'],
                      productId: product['id'],
                      image: product['image'],
                      title: product['name'],
                      quantity: '${product['stockQuantity']} unit/s',
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildItemCard({
    required BuildContext context,
    required String categoryId,
    required String productId,
    String? image,
    Color? color,
    required String title,
    required String quantity,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageWidth = screenWidth * 0.14;
    final double imageHeight = screenWidth * 0.12;
    final double padding = screenWidth * 0.02;

    return Container(
      padding: EdgeInsets.fromLTRB(padding, 6, padding, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            SizedBox(width: padding),
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: padding),
            Text(
              quantity,
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: padding),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      categoryId: categoryId,
                      productId: productId,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: padding, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B2117),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  'Details',
                  style: TextStyle(
                    color: Color(0xFFFFF4E6),
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}