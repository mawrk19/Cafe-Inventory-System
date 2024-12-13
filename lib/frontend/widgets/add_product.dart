import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/firestore.dart';

class AddProductModal extends StatefulWidget {
  final String categoryId;
  final VoidCallback onProductAdded;

  const AddProductModal({
    Key? key,
    required this.categoryId,
    required this.onProductAdded,
  }) : super(key: key);

  @override
  _AddProductModalState createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductModal> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  String name = '';
  String description = '';
  double price = 0.0;
  int stockQuantity = 0;
  String barcode = '';
  DateTime expirationDate = DateTime.now();
  String batchId = '';
  DateTime manufactureDate = DateTime.now();
  int shelfLife = 0;
  String storageConditions = '';
  String status = '';
  String imageUrl = 'assets/images/ProductPhoto.png'; // Default image

  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _manufactureDateController = TextEditingController();

  // Function to handle image selection
  Future<void> _pickImage() async {
    // Implement image picker logic here
    // If no image is selected, imageUrl will stay as the default
    setState(() {
      // Example of setting a custom image URL
      imageUrl = 'path_to_selected_image';
    });
  }

  // Function to submit the form
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final docId = DateTime.now().millisecondsSinceEpoch.toString();
      await _firestoreService.addProduct(widget.categoryId, docId, {
        'id': docId,
        'name': name,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'barcode': barcode,
        'expirationDate': expirationDate,
        'batchId': batchId,
        'manufactureDate': manufactureDate,
        'shelfLife': shelfLife,
        'storageConditions': storageConditions,
        'status': status,
        'imageUrl': imageUrl,
      });

      widget.onProductAdded(); // Callback to refresh the product list
      Navigator.pop(context); // Close the modal after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Product'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) => price = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
                onSaved: (value) => stockQuantity = int.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Barcode'),
                onSaved: (value) => barcode = value!,
              ),
              TextFormField(
                controller: _expirationDateController,
                decoration: const InputDecoration(labelText: 'Expiration Date'),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: expirationDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != expirationDate) {
                    setState(() {
                      expirationDate = picked;
                      _expirationDateController.text = expirationDate.toLocal().toString().split(' ')[0];
                    });
                  }
                },
                readOnly: true,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Batch ID'),
                onSaved: (value) => batchId = value!,
              ),
              TextFormField(
                controller: _manufactureDateController,
                decoration: const InputDecoration(labelText: 'Manufacture Date'),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: manufactureDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != manufactureDate) {
                    setState(() {
                      manufactureDate = picked;
                      _manufactureDateController.text = manufactureDate.toLocal().toString().split(' ')[0];
                    });
                  }
                },
                readOnly: true,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Shelf Life (in days)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => shelfLife = int.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Storage Conditions'),
                onSaved: (value) => storageConditions = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status'),
                onSaved: (value) => status = value!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
