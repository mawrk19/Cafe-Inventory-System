import 'package:flutter/material.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> customer;

  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
        backgroundColor: const Color(0xFF6F4E37), // Coffee theme color
        foregroundColor: const Color(0xFFF8F8FF), // Offwhite font color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB0814F),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFFFF4E6),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/customers.png',
                    height: 150,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Full Name: ${customer['ownerName']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('Email: ${customer['email']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('Contact Number: ${customer['contactNumber']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('Branch Number: ${customer['branchNumber']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('Region: ${customer['region']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('Province: ${customer['province']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('City: ${customer['city']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('Barangay: ${customer['baranggay']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('Address: ${customer['address']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
                const SizedBox(height: 8),
                Text('Owner Information: ${customer['ownerInformation']}', style: const TextStyle(fontSize: 18, color: Color(0xFFFFF4E6))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
