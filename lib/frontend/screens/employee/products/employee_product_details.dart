import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/firestore_service.dart'; // Firestore service to fetch product details
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package for Timestamp

class EmployeeProductDetailScreen extends StatefulWidget {
  final String categoryId;
  final String productId;

  const EmployeeProductDetailScreen({
    super.key,
    required this.categoryId,
    required this.productId,
  });

  @override
  _EmployeeProductDetailScreenState createState() => _EmployeeProductDetailScreenState();
}

class _EmployeeProductDetailScreenState extends State<EmployeeProductDetailScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic>? _productDetails;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    final product = await _firestoreService.getProductById(widget.categoryId, widget.productId);
    setState(() {
      _productDetails = product ?? {};
    });
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'No date available';
    final DateTime dateTime = timestamp.toDate();
    return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _productDetails != null && _productDetails!.isNotEmpty
              ? _productDetails!['name']
              : 'Loading...',
        ),
      ),
      body: _productDetails == null || _productDetails!.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _productDetails!['image'] != null && _productDetails!['image'].startsWith('http')
                          ? Image.network(
                              _productDetails!['image'],
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.contain, // Changed to BoxFit.contain to always show the full image
                            )
                          : Image.asset(
                              _productDetails!['image'] ?? 'assets/images/ProductPhoto.png',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.contain, // Changed to BoxFit.contain to always show the full image
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Price: ₱${_productDetails!['price']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Quantity: ${_productDetails!['stockQuantity']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['description'] ??
                        'No description available.'),
                    const SizedBox(height: 16),
                    const Text(
                      'Barcode:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['barcode'] ?? 'No barcode available.'),
                    const SizedBox(height: 16),
                    const Text(
                      'Batch ID:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['batchId'] ?? 'No batch ID available.'),
                    const SizedBox(height: 16),
                    const Text(
                      'Expiration Date:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_formatTimestamp(_productDetails!['expirationDate'])),
                    const SizedBox(height: 16),
                    const Text(
                      'Manufacture Date:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_formatTimestamp(_productDetails!['manufactureDate'])),
                    const SizedBox(height: 16),
                    const Text(
                      'Shelf Life:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('${_productDetails!['shelfLife']} days'),
                    const SizedBox(height: 16),
                    const Text(
                      'Status:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['status'] ?? 'No status available.'),
                    const SizedBox(height: 16),
                    const Text(
                      'Stock Quantity:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('${_productDetails!['stockQuantity']} units'),
                    const SizedBox(height: 16),
                    const Text(
                      'Storage Conditions:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['storageConditions'] ?? 'No storage conditions available.'),
                  ],
                ),
              ),
            ),
    );
  }
}
