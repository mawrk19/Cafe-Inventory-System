import 'package:flutter/material.dart';

class BranchTable extends StatelessWidget {
  const BranchTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 10), // Slightly reduced padding
      decoration: BoxDecoration(
        color: const Color(0xFF753D29),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Branch Name',
              style: const TextStyle(
                color: Color(0xFFFFF4E6),
                fontSize: 14, // Reduced font size for readability
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          VerticalDivider(
            color: const Color(0xFFFFF4E6),
            thickness: 1,
            width: 20,
          ),
          Expanded(
            child: Text(
              'Orders Made',
              style: const TextStyle(
                color: Color(0xFFFFF4E6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          VerticalDivider(
            color: const Color(0xFFFFF4E6),
            thickness: 1,
            width: 20,
          ),
          Expanded(
            child: Text(
              'Total Costs',
              style: const TextStyle(
                color: Color(0xFFFFF4E6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}