import 'package:flutter/material.dart';

class PopularItems extends StatelessWidget {
  const PopularItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 27),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E6),
        borderRadius: BorderRadius.circular(33),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 6, 17, 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/ProductPhoto.png',
                  width: 54,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                'Vietnamese Beans',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Text(
                '2lbs',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B2117),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Details',
                      style: TextStyle(
                        color: Color(0xFFFFF4E6),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}