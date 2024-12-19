import 'package:flutter/material.dart';

class StockChart extends StatelessWidget {
  const StockChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0E2C5),
        borderRadius: BorderRadius.circular(33),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3B2117),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Daily',
                    style: TextStyle(
                      color: Color(0xFFF0E2C5),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Image.asset(
                    'assets/images/arrow_down.png',
                    width: 15,
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 26),
          SizedBox(
            height: 138,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                10,
                (index) => Container(
                  width: 19,
                  height: [55.0, 91.0, 101.0, 79.0, 85.0, 129.0, 138.0, 111.0, 91.0, 65.0][index],
                  color: [
                    const Color(0xFF753D29),
                    const Color(0xFFB0814F),
                    const Color(0xFF3B2117),
                    const Color(0xFF753D29),
                    const Color(0xFFB0814F),
                    const Color(0xFF3B2117),
                    const Color(0xFF240C10),
                    const Color(0xFF3B2117),
                    const Color(0xFFB0814F),
                    const Color(0xFF753D29),
                  ][index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}