import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BranchCategory extends StatefulWidget {
  const BranchCategory({Key? key}) : super(key: key);

  @override
  _BranchCategoryState createState() => _BranchCategoryState();
}

class _BranchCategoryState extends State<BranchCategory> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchCategoryCards() async {
    try {
      QuerySnapshot snapshot = await _db.collection('categories').get();
      return snapshot.docs.map((doc) {
        return {
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch category cards: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch Categories'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCategoryCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var category = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(category['name']),
                    subtitle: Text(category['description']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
