import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/products_service.dart';

class EditProductModal extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function onProductEdited;

  const EditProductModal({
    Key? key,
    required this.product,
    required this.onProductEdited,
  }) : super(key: key);

  @override
  _EditProductModalState createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  final FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _stockQuantityController;
  late TextEditingController _storageConditionsController;
  late TextEditingController _shelfLifeController;
  late TextEditingController _barcodeController;
  late TextEditingController _batchIdController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name']);
    _descriptionController = TextEditingController(text: widget.product['description']);
    _priceController = TextEditingController(text: widget.product['price'].toString());
    _stockQuantityController = TextEditingController(text: widget.product['stockQuantity'].toString());
    _storageConditionsController = TextEditingController(text: widget.product['storageConditions']);
    _shelfLifeController = TextEditingController(text: widget.product['shelfLife'].toString());
    _barcodeController = TextEditingController(text: widget.product['barcode']);
    _batchIdController = TextEditingController(text: widget.product['batchId']);
    _imageController = TextEditingController(text: widget.product['image']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockQuantityController.dispose();
    _storageConditionsController.dispose();
    _shelfLifeController.dispose();
    _barcodeController.dispose();
    _batchIdController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _editProduct() async {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'stockQuantity': int.parse(_stockQuantityController.text),
        'storageConditions': _storageConditionsController.text,
        'shelfLife': int.parse(_shelfLifeController.text),
        'barcode': _barcodeController.text,
        'batchId': _batchIdController.text,
        'image': _imageController.text,
        'status': widget.product['status'],
        'categoryId': widget.product['categoryId'],
        'manufactureDate': widget.product['manufactureDate'],
        'expirationDate': widget.product['expirationDate'],
      };

      try {
        await _firestoreService.editProduct(
          widget.product['categoryId'],
          widget.product['id'],
          updatedProduct,
        );
        widget.onProductEdited();
      } catch (e) {
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Product'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockQuantityController,
                decoration: const InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _storageConditionsController,
                decoration: const InputDecoration(labelText: 'Storage Conditions'),
              ),
              TextFormField(
                controller: _shelfLifeController,
                decoration: const InputDecoration(labelText: 'Shelf Life'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _barcodeController,
                decoration: const InputDecoration(labelText: 'Barcode'),
              ),
              TextFormField(
                controller: _batchIdController,
                decoration: const InputDecoration(labelText: 'Batch ID'),
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _editProduct();
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
