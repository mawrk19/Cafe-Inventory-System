import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/products_service.dart';
import 'package:kopilism/frontend/widgets/sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminArchivedCategories extends StatefulWidget {
  const AdminArchivedCategories({super.key});

  @override
  State<AdminArchivedCategories> createState() => _AdminArchivedCategoriesState();
}

class _AdminArchivedCategoriesState extends State<AdminArchivedCategories> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _archivedCategories = [];
  List<String> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchArchivedCategories();
  }

  Future<void> _fetchArchivedCategories() async {
    final categories = await _firestoreService.getArchivedCategories();
    setState(() {
      _archivedCategories = categories;
    });
  }

  void _toggleSelection(String categoryId) {
    setState(() {
      if (_selectedCategories.contains(categoryId)) {
        _selectedCategories.remove(categoryId);
      } else {
        _selectedCategories.add(categoryId);
      }
    });
  }

  void _selectAll() {
    setState(() {
      _selectedCategories = _archivedCategories.map((category) => category['id'] as String).toList();
    });
  }

  void _deselectAll() {
    setState(() {
      _selectedCategories.clear();
    });
  }

  Future<void> _retrieveSelected() async {
    for (String categoryId in _selectedCategories) {
      await _firestoreService.updateCategory(categoryId, {'status': 'active'});
    }
    _fetchArchivedCategories();
    _deselectAll();
    Fluttertoast.showToast(msg: 'Selected categories retrieved successfully');
    _createNotification('Retrieve', 'Selected categories retrieved successfully');
  }

  Future<void> _deleteSelected() async {
    for (String categoryId in _selectedCategories) {
      await _firestoreService.deleteCategory(categoryId);
    }
    _fetchArchivedCategories();
    _deselectAll();
    Fluttertoast.showToast(msg: 'Selected categories deleted successfully');
    _createNotification('Delete', 'Selected categories deleted successfully');
  }

  Future<void> _createNotification(String header, String message) async {
    await FirebaseFirestore.instance.collection('notifications').doc('users').collection('admin').add({
      'header': header,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
    });
  }

  void _showCategoryOptions(String categoryId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archive'),
              onTap: () {
                Navigator.pop(context);
                _archiveCategory(categoryId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _editCategory(categoryId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _archiveCategory(String categoryId) async {
    await _firestoreService.updateCategory(categoryId, {'status': 'archived'});
    _fetchArchivedCategories();
    Fluttertoast.showToast(msg: 'Category archived successfully');
    _createNotification('Archive', 'Category archived successfully');
  }

  void _editCategory(String categoryId) {
    // Navigate to the edit category screen
    Navigator.pushNamed(context, '/edit-category', arguments: categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _archivedCategories.isEmpty
                  ? const Center(child: Text('No archived categories available'))
                  : ListView.builder(
                      itemCount: _archivedCategories.length,
                      itemBuilder: (context, index) {
                        final category = _archivedCategories[index];
                        final isSelected = _selectedCategories.contains(category['id']);
                        return GestureDetector(
                          onLongPress: () {
                            _showCategoryOptions(category['id']);
                          },
                          child: ListTile(
                            title: Text(category['name'] ?? 'Unnamed'),
                            subtitle: const Text('Archived'),
                            leading: Image.asset(
                              _firestoreService.getImageUrl(category['image']),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                _toggleSelection(category['id']);
                              },
                            ),
                            onTap: () {
                              _toggleSelection(category['id']);
                            },
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 60, // Adjust the height as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _selectAll,
                      child: const Text('Select All'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 40), // Adjust button size
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _deselectAll,
                      child: const Text('Deselect All'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 40), // Adjust button size
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _retrieveSelected,
                      child: const Text('Retrieve'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 40), // Adjust button size
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _deleteSelected,
                      child: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 40), // Adjust button size
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32), // Adjust the height to make the buttons lower
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
