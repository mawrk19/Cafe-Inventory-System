import 'package:flutter/material.dart';

class CustomersCard extends StatelessWidget {
  final String branchNumber;
  final String city;
  final String region;

  const CustomersCard({
    super.key,
    required this.branchNumber,
    required this.city,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust height as needed
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0E2C5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView( // Add this line
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 140, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/customers.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50);
                  },
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Branch $branchNumber',
              style: const TextStyle(
                color: Color(0xFF3B2117),
                fontSize: 16,
                fontWeight: FontWeight.w800,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.left, // Align text to the left
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '$city, $region',
              style: const TextStyle(
                color: Color(0xFF3B2117),
                fontSize: 14, // Make the font a bit lighter
                fontWeight: FontWeight.w600, // Make the font a bit lighter
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.left, // Align text to the left
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
