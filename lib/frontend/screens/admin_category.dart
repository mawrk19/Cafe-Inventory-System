import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/backend/services/firestore.dart'; // Import the Firestore service

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
      body: _categories.isEmpty
          ? const Center(child: Text('No categories available'))
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return ListTile(
                  title: Text(category['name'] ?? 'Unnamed'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _firestoreService.deleteCategory(category['id']);
                      _fetchCategories();
                    },
                  ),
                );
              },
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
