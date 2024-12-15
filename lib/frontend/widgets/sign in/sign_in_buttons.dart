import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kopilism/theme/app_theme.dart';
import 'package:kopilism/theme/colors.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    const buttons = [
      {'label': 'Admin', 'route': '/AdminLogIn'},
      {'label': 'Employee', 'route': '/EmployeeLogIn'},
      {'label': 'Branch Client', 'route': '/BranchLogIn'},
    ];

    return Align(
      alignment: Alignment.center,  // Center align the Column
      child: Padding(
        padding: EdgeInsets.only(top: 150.h),  // Add more top padding to push the buttons down
        child: Column(
          mainAxisSize: MainAxisSize.min,  // Minimize column height
          children: buttons.map((button) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),  // Scaled vertical padding
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,  // Use color from AppColors
                  padding: EdgeInsets.symmetric(vertical: 10.h),  // Scaled padding
                  minimumSize: Size(237.w, 55.h),  // Scaled minimum size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),  // Responsive border radius
                  ),
                  elevation: 4,  // Shadow effect
                ),
                onPressed: () => Navigator.pushNamed(context, button['route']!),
                child: Text(
                  button['label']!,
                  style: AppTheme.textTheme.labelLarge,  // Use button text style from AppTheme
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
