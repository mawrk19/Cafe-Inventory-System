// Updated AdminCategory Screen
import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/employee_bottom_nav_bar.dart';
import 'package:kopilism/backend/services/products_service.dart';
import 'package:kopilism/frontend/screens/employee/products/employee_products.dart';

class EmployeeCategory extends StatefulWidget {
  const EmployeeCategory({super.key});

  @override
  State<EmployeeCategory> createState() => _EmployeeCategoryState();
}

class _EmployeeCategoryState extends State<EmployeeCategory> {
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
      appBar: AppBar(
        title: const Text('Employee Categories Screen'),
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
                          builder: (context) => EmployeeProducts(
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
      bottomNavigationBar: const EmployeeBottomNavBar(),
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

