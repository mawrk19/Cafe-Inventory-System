import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/orders/order_container.dart';

class OrderItemList extends StatelessWidget {
  const OrderItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedBoxContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ORDER0001',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Column(
              children: [
                Text('DEC 24,'),
                Text('2024'),
              ],
            ),
            const Text(
              'P5000',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('STATUS'),
            ),
          ],
        ),
      ],
    ));
  }
} 