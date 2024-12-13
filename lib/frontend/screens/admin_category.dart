import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/backend/services/firestore.dart'; // Import the Firestore service
import 'package:kopilism/frontend/widgets/category_card.dart'; // Import the CategoryCard widget
import 'package:kopilism/frontend/screens/admin_products.dart'; // Import the AdminProducts screen

class AdminCategory extends StatefulWidget {
  const AdminCategory({super.key});

  @override
  State<AdminCategory> createState() => _AdminCategoryState();
}

class _AdminCategoryState extends State<AdminCategory> {
  final FirestoreService _firestoreService = FirestoreService();

  // Holds the categories retrieved from Firestore
  List<Map<String, dynamic>> _categories = [];

  // Fetch categories on initialization
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
      appBar: AppBar(
        title: const Text('Categories Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCategoryDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding around the grid
        child: _categories.isEmpty
            ? const Center(child: Text('No categories available'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust the number of columns
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the AdminProducts screen of the selected category
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
                      fontSize: 16, // Adjust the font size as needed
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: const BottomNavBar(), // Use your custom widget
    );
  }

  void _showCategoryDialog(BuildContext context, {String? id, String? currentName}) {
    final TextEditingController categoryController =
        TextEditingController(text: currentName ?? '');
    final isEdit = id != null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Category' : 'Add Category'),
          content: TextField(
            controller: categoryController,
            decoration: const InputDecoration(hintText: 'Enter category'),
          ),
          actions: <Widget>[
            if (isEdit)
              TextButton(
                onPressed: () async {
                  final updatedName = categoryController.text.trim();
                  if (updatedName.isNotEmpty) {
                    await _firestoreService.editCategory(id, {'name': updatedName});
                    Navigator.of(context).pop();
                    _fetchCategories();
                  }
                },
                child: const Text('Edit'),
              ),
            TextButton(
              onPressed: () async {
                final newName = categoryController.text.trim();
                if (newName.isNotEmpty) {
                  final docId = isEdit ? id : DateTime.now().millisecondsSinceEpoch.toString();
                  await _firestoreService.addCategory(docId, {'id': docId, 'name': newName});
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
