import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/products_service.dart';
import 'package:kopilism/frontend/widgets/sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';

class AdminArchivedCategories extends StatefulWidget {
  const AdminArchivedCategories({super.key});

  @override
  State<AdminArchivedCategories> createState() => _AdminArchivedCategoriesState();
}

class _AdminArchivedCategoriesState extends State<AdminArchivedCategories> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _archivedCategories = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _archivedCategories.isEmpty
            ? const Center(child: Text('No archived categories available'))
            : ListView.builder(
                itemCount: _archivedCategories.length,
                itemBuilder: (context, index) {
                  final category = _archivedCategories[index];
                  return ListTile(
                    title: Text(category['name'] ?? 'Unnamed'),
                    subtitle: Text('Archived'),
                    leading: Image.asset(
                      _firestoreService.getImageUrl(category['image']),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
