import 'package:flutter/material.dart';
import 'dart:math';

class InventoryItems extends StatelessWidget {
  const InventoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(10, (index) {
        // Generate a random string of numbers
        final random = Random();
        final randomNumber = List.generate(6, (_) => random.nextInt(10)).join();
        final phpNumber = List.generate(random.nextInt(3) + 2, (_) => random.nextInt(10)).join(); // Generate 2-4 random numbers

        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      color: Colors.grey, // Placeholder color for the image
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Item $index',
                      style: const TextStyle(
                        fontSize: 14, // Matches padding style
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Colors.black26,
                thickness: 1,
                width: 20,
              ),
              Expanded(
                child: Text(
                  randomNumber,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalDivider(
                color: Colors.black26,
                thickness: 1,
                width: 20,
              ),
              Expanded(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalDivider(
                color: Colors.black26,
                thickness: 1,
                width: 20,
              ),
              Expanded(
                child: Text(
                  'Php $phpNumber',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}