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

  Future<void> _updateProductDetails() async {
    if (_productDetails != null) {
      await _firestoreService.updateProductPrice(widget.categoryId, widget.productId, _productDetails!['price']);
      await _firestoreService.updateProductQuantity(widget.categoryId, widget.productId, _productDetails!['stockQuantity']);
      await _firestoreService.updateProductDescription(widget.categoryId, widget.productId, _productDetails!['description']);
      await _firestoreService.updateProductBarcode(widget.categoryId, widget.productId, _productDetails!['barcode']);
      await _firestoreService.updateProductBatchId(widget.categoryId, widget.productId, _productDetails!['batchId']);
      await _firestoreService.updateProductExpirationDate(widget.categoryId, widget.productId, _productDetails!['expirationDate']);
      await _firestoreService.updateProductManufactureDate(widget.categoryId, widget.productId, _productDetails!['manufactureDate']);
      await _firestoreService.updateProductShelfLife(widget.categoryId, widget.productId, _productDetails!['shelfLife']);
      await _firestoreService.updateProductStorageConditions(widget.categoryId, widget.productId, _productDetails!['storageConditions']);
      await _firestoreService.updateProductSku(widget.categoryId, widget.productId, _productDetails!['sku']);
    }
  }

  void _showEditPopup(String field, String currentValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: field),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
                    Row(
                      children: [
                        Text(
                          'Price: ₱${_productDetails!['price']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Price', _productDetails!['price'].toString(), (value) {
                              setState(() {
                                _productDetails!['price'] = double.tryParse(value) ?? _productDetails!['price'];
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Quantity: ${_productDetails!['stockQuantity']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Quantity', _productDetails!['stockQuantity'].toString(), (value) {
                              setState(() {
                                if (value != null && value.isNotEmpty) {
                                  _productDetails!['stockQuantity'] = int.tryParse(value) ?? _productDetails!['stockQuantity'];
                                }
                              });
                              _updateProductDetails().then((_) => _fetchProductDetails());
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Description', _productDetails!['description'], (value) {
                              setState(() {
                                _productDetails!['description'] = value;
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['description'] ?? 'No description available.'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Barcode:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Barcode', _productDetails!['barcode'], (value) {
                              setState(() {
                                _productDetails!['barcode'] = value;
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['barcode'] ?? 'No barcode available.'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Batch ID:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Batch ID', _productDetails!['batchId'], (value) {
                              setState(() {
                                _productDetails!['batchId'] = value;
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['batchId'] ?? 'No batch ID available.'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Expiration Date:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Expiration Date', _formatTimestamp(_productDetails!['expirationDate']), (value) {
                              setState(() {
                                _productDetails!['expirationDate'] = Timestamp.fromDate(DateTime.tryParse(value) ?? _productDetails!['expirationDate'].toDate());
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_formatTimestamp(_productDetails!['expirationDate'])),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Manufacture Date:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Manufacture Date', _formatTimestamp(_productDetails!['manufactureDate']), (value) {
                              setState(() {
                                _productDetails!['manufactureDate'] = Timestamp.fromDate(DateTime.tryParse(value) ?? _productDetails!['manufactureDate'].toDate());
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_formatTimestamp(_productDetails!['manufactureDate'])),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Shelf Life:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Shelf Life', _productDetails!['shelfLife'].toString(), (value) {
                              setState(() {
                                _productDetails!['shelfLife'] = int.tryParse(value) ?? _productDetails!['shelfLife'];
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('${_productDetails!['shelfLife']} days'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Stock Quantity:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Stock Quantity', _productDetails!['stockQuantity'].toString(), (value) {
                              setState(() {
                                if (value != null && value.isNotEmpty) {
                                  _productDetails!['stockQuantity'] = int.tryParse(value) ?? _productDetails!['stockQuantity'];
                                }
                              });
                              _updateProductDetails().then((_) => _fetchProductDetails());
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('${_productDetails!['stockQuantity']} units'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Storage Conditions:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('Storage Conditions', _productDetails!['storageConditions'], (value) {
                              setState(() {
                                _productDetails!['storageConditions'] = value;
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_productDetails!['storageConditions'] ?? 'No storage conditions available.'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'SKU: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditPopup('SKU', _productDetails!['sku'], (value) {
                              setState(() {
                                _productDetails!['sku'] = value;
                              });
                              _updateProductDetails();
                            });
                          },
                        ),
                      ],
                    ),
                    Text('${_productDetails!['sku']}'),
                  ],
                ),
              ),
            ),
    );
  }
}
