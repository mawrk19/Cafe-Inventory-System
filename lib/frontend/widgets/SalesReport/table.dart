import 'package:flutter/material.dart';

class InventoryTable extends StatelessWidget {
  const InventoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 10), // Slightly reduced padding
      decoration: BoxDecoration(
        color: Color(0xFF753D29),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
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
              'Item',
              style: TextStyle(
                color: Color(0xFFFFF4E6),
                fontSize: 14, // Reduced font size for readability
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          VerticalDivider(
            color: Color(0xFFFFF4E6),
            thickness: 1,
            width: 20,
          ),
          Expanded(
            child: Text(
              'Batch Number',
              style: TextStyle(
                color: Color(0xFFFFF4E6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          VerticalDivider(
            color: Color(0xFFFFF4E6),
            thickness: 1,
            width: 20,
          ),
          Expanded(
            child: Text(
              'Quantity',
              style: TextStyle(
                color: Color(0xFFFFF4E6),
                fontSize: 14, // Reduced font size for consistency
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          VerticalDivider(
            color: Color(0xFFFFF4E6),
            thickness: 1,
            width: 20,
          ),
          Expanded(
            child: Text(
              'Total Costs',
              style: TextStyle(
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
