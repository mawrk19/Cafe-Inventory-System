import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/products_service.dart';

class AddProductModal extends StatefulWidget {
  final String categoryId;
  final VoidCallback onProductAdded;

  const AddProductModal({
    super.key,
    required this.categoryId,
    required this.onProductAdded,
  });

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
  String status = 'active'; // Default status
  String image = 'assets/images/ProductPhoto.png'; // Default image
  String sku = ''; // Add SKU field

  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _manufactureDateController = TextEditingController();

  // Function to handle image selection
  void _pickImage(String selectedImage) {
    setState(() {
      image = selectedImage;
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
        'status': status, // Ensure status is set to 'available'
        'image': image, // Changed from 'imageUrl' to 'image'
        'categoryId': widget.categoryId,
        'sku': sku, // Add SKU field
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
              // Product Name Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              // Description Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
                onSaved: (value) => description = value!,
              ),
              // Price Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) => price = double.parse(value!),
              ),
              // Stock Quantity Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Stock Quantity',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
                onSaved: (value) => stockQuantity = int.parse(value!),
              ),
              // Barcode Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Barcode',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
                onSaved: (value) => barcode = value!,
              ),
              // Expiration Date Input
              TextFormField(
                controller: _expirationDateController,
                decoration: InputDecoration(
                  labelText: 'Expiration Date',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
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
              // Batch ID Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Batch ID',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
                onSaved: (value) => batchId = value!,
              ),
              // Manufacture Date Input
              TextFormField(
                controller: _manufactureDateController,
                decoration: InputDecoration(
                  labelText: 'Manufacture Date',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
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
              // Shelf Life Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Shelf Life (in days)',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => shelfLife = int.parse(value!),
              ),
              // Storage Conditions Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Storage Conditions',
                  filled: true,
                  fillColor: Color(0xFFFFFDD0), // Cream color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped
                  ),
                ),
                onSaved: (value) => storageConditions = value!,
              ),
              const SizedBox(height: 16),
              // Image Picker Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _pickImage('assets/images/milk.png'),
                    child: Image.asset('assets/images/milk.png', width: 50, height: 50),
                  ),
                  GestureDetector(
                    onTap: () => _pickImage('assets/images/cups.png'),
                    child: Image.asset('assets/images/cups.png', width: 50, height: 50),
                  ),
                  GestureDetector(
                    onTap: () => _pickImage('assets/images/ProductPhoto.png'),
                    child: Image.asset('assets/images/ProductPhoto.png', width: 50, height: 50),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Image Preview Section
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.asset(
                  image,
                  width: 100, // You can adjust the size
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50);
                  },
                ),
              ),
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
