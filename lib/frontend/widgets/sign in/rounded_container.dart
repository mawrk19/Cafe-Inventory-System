import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (1.sw - 337.w) / 2, // Centers the container based on the screen width
      top: 0.35.sh, // 35% from the top of the screen
      child: Container(
        width: 337.w, // Scaled width
        height: 0.31.sh, // Scaled height (50% of the screen height)
        decoration: ShapeDecoration(
          color: const Color(0xFFFFF4E6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r), // Responsive border radius
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}
