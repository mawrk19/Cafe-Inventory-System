import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (1.sw - 296.w) / 2, // Centers the logo based on the screen width
      top: 0.08.sh, // 8% from the top of the screen
      child: Container(
        width: 296.w, // Scaled width
        height: 244.h, // Scaled height
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/kopilismLogo.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
