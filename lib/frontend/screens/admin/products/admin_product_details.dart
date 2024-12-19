import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/products_service.dart'; // Firestore service to fetch product details
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package for Timestamp

class ProductDetailScreen extends StatefulWidget {
  final String categoryId;
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.categoryId,
    required this.productId,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic>? _productDetails;
  final TextEditingController _controller = TextEditingController();

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

  Future<void> _updateProductField(String field, String value) async {
    await _firestoreService.editProduct(widget.categoryId, widget.productId, {field: value});
    await _firestoreService.addNotification('Product Updated', 'The $field of the product has been updated.');
    _fetchProductDetails();
  }

  Future<void> _showEditDialog(String field, String currentValue) async {
    _controller.text = currentValue;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter new $field'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _updateProductField(field, _controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
                    _buildEditableField('Price', '₱${_productDetails!['price']}'),
                    const SizedBox(height: 8),
                    _buildEditableField('Quantity', '${_productDetails!['stockQuantity']}'),
                    const SizedBox(height: 16),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('Description', _productDetails!['description'] ?? 'No description available.'),
                    const SizedBox(height: 16),
                    const Text(
                      'Barcode:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('Barcode', _productDetails!['barcode'] ?? 'No barcode available.'),
                    const SizedBox(height: 16),
                    const Text(
                      'Batch ID:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('Batch ID', _productDetails!['batchId'] ?? 'No batch ID available.'),
                    const SizedBox(height: 16),
                    const Text(
                      'Expiration Date:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('Expiration Date', _formatTimestamp(_productDetails!['expirationDate'])),
                    const SizedBox(height: 16),
                    const Text(
                      'Manufacture Date:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('Manufacture Date', _formatTimestamp(_productDetails!['manufactureDate'])),
                    const SizedBox(height: 16),
                    const Text(
                      'Shelf Life:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('Shelf Life', '${_productDetails!['shelfLife']} days'),
                    const SizedBox(height: 16),
                    const Text(
                      'Stock Quantity:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('Stock Quantity', '${_productDetails!['stockQuantity']} units'),
                    const SizedBox(height: 16),
                    const Text(
                      'SKU:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('SKU', '${_productDetails!['sku']}'),
                    const SizedBox(height: 16),
                    const Text(
                      'Storage Conditions:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditableField('Storage Conditions', _productDetails!['storageConditions'] ?? 'No storage conditions available.'),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildEditableField(String field, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$field: $value',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            _showEditDialog(field, value);
          },
        ),
      ],
    );
  }
}
