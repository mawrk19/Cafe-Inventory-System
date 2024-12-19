import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/sign%20in/logo.dart';
import '../widgets/sign in/rounded_container.dart';
import '../widgets/sign in/title_box.dart';
import '../widgets/sign in/sign_in_buttons.dart';
import 'admin/admin_login.dart';
import 'employee/employee_login.dart';
import 'branch/branch_login.dart'; // Import the branch login screen

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          const LogoWidget(), // No need to pass dimensions
          const RoundedContainer(),
          const TitleBox(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 240.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminLogin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Admin Login'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EmployeeLogin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Employee Login'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BranchLogin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Branch Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
