// Updated AdminCategory Screen
import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/backend/services/firestore_service.dart';
import 'package:kopilism/frontend/screens/admin/products/admin_products.dart';
import 'package:kopilism/frontend/widgets/sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';

class AdminCategory extends StatefulWidget {
  const AdminCategory({super.key});

  @override
  State<AdminCategory> createState() => _AdminCategoryState();
}

class _AdminCategoryState extends State<AdminCategory> {
  final FirestoreService _firestoreService = FirestoreService();
  // Removed: final ImagePicker _picker = ImagePicker();

  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await _firestoreService.getAllCategories();
    setState(() {
      _categories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(), // Use the custom TopNavBar
      drawer: const Sidebar(), // Add the Sidebar as the drawer
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCategoryDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _categories.isEmpty
            ? const Center(child: Text('No categories available'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 4, // Adjust this ratio as needed
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminProducts(
                            categoryId: category['id'],
                            categoryName: category['name'],
                          ),
                        ),
                      );
                    },
                    child: CategoryCard(
                      title: category['name'] ?? 'Unnamed',
                      fontSize: 16,
                      imageUrl: _firestoreService.getImageUrl(category['image']),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  void _showCategoryDialog(BuildContext context, {String? id, String? currentName, String? currentImage}) {
  final TextEditingController categoryController =
      TextEditingController(text: currentName ?? '');
  final isEdit = id != null;
  String? selectedImage;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(isEdit ? 'Edit Category' : 'Add Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(hintText: 'Enter category name'),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedImage,
              hint: const Text('Select an image'),
              items: [
                'assets/images/milk.png',
                'assets/images/cups.png',
                'assets/images/ProductPhoto.png'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Container(
                        width: 40, // Image thumbnail width
                        height: 40, // Image thumbnail height
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: selectedImage == value
                              ? Border.all(color: Colors.blue, width: 2) // Highlight selected image
                              : null,
                        ),
                        child: Image.asset(
                          value,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(value.split('/').last),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedImage = newValue;
                });
              },
            ),
            if (selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    const Text('Selected Image Preview'),
                    SizedBox(
                      width: 100, // Adjust size for preview
                      height: 100, // Adjust size for preview
                      child: Image.asset(
                        selectedImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 50);
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              final newName = categoryController.text.trim();
              final imageUrl = selectedImage ?? currentImage ?? 'assets/images/ProductPhoto.png';

              if (newName.isNotEmpty) {
                final docId = isEdit ? id : DateTime.now().millisecondsSinceEpoch.toString();
                await _firestoreService.addCategory(docId, {'id': docId, 'name': newName, 'image': imageUrl});
                Navigator.of(context).pop();
                _fetchCategories();
              }
            },
            child: Text(isEdit ? 'Save' : 'Add'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
}

// Updated CategoryCard Widget
class CategoryCard extends StatelessWidget {
  final String title;
  final double fontSize;
  final String imageUrl;

  const CategoryCard({
    super.key,
    required this.title,
    required this.fontSize,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Reduced height for the entire card box
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0E2C5),
        borderRadius: BorderRadius.circular(15),
        // Removed boxShadow
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 140, // Reduced height for the image container
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 50);
                },
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF3B2117),
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

