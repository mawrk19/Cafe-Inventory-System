import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPrompt extends StatelessWidget {
  const RegisterPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Center everything horizontally and adjust position vertically
        Positioned(
          left: 0, // Remove left position, use alignment for centering
          bottom: 50.h, // Adjust vertical position to be closer to the bottom
          right: 0, // This will make the left and right both start from the edges
          child: Align(
            alignment: Alignment.center, // This will center the Column horizontally
            child: Column(
              children: [
                Text(
                  'Don’t have an account yet?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp, // Scaled font size
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w200,
                    letterSpacing: 0.24.sp, // Scaled letter spacing
                  ),
                ),
                SizedBox(height: 10.h), // Scaled vertical spacing
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/Registration'),
                  child: Container(
                    width: 200.w, // Scaled width
                    height: 55.h, // Scaled height
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF0E2C5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r), // Scaled border radius
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
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 20.sp, // Scaled font size
                          color: const Color(0xFF3B2117),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
