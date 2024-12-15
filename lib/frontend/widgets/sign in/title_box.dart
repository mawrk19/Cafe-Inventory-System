import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleBox extends StatelessWidget {
  const TitleBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (1.sw - 319.w) / 2, // Centers the title box based on screen width
      top: 0.37.sh, // 37% from the top of the screen
      child: Container(
        width: 319.w, // Scaled width
        height: 66.h, // Scaled height
        decoration: ShapeDecoration(
          color: const Color(0xFFB0814F),
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
        child: Center(
          child: Text(
            'SIGN IN AS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp, // Scaled font size
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5.sp, // Scaled letter spacing
            ),
          ),
        ),
      ),
    );
  }
}
