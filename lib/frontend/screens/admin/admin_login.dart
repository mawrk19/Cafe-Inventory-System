import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/authentication.dart';
import 'package:kopilism/backend/services/shared_preference_service.dart';
import 'package:kopilism/frontend/widgets/sign in/logo.dart';
import 'package:kopilism/frontend/widgets/login/associate.dart';
import 'package:kopilism/frontend/screens/admin/admin_dashboard.dart';
import 'package:kopilism/frontend/screens/employee/employee_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final AuthenticationService _authService = AuthenticationService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
      _login();
    }
  }

  Future<void> _login() async {
  setState(() {
    _isLoading = true;
  });

  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  try {
    final user = await _authService.login(email, password);
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);

      final userDoc = await _authService.getUserData(user.uid);
      final userData = userDoc.data() as Map<String, dynamic>;

      // Prepare a map to store multiple values at once
      Map<String, String> dataToStore = {
        'userId': user.uid,
        'userRole': userData['role'],
        'fullName': userData['fullName'],
        'email': userData['email'],
        // Add any other fields you need
      };

      // Store all data using the service
      await SharedPreferencesService.saveMultiple(dataToStore);

      if (userData['role'] == 'admin' || userData['role'] == 'ownerAdmin') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else if (userData['role'] == 'employee') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmployeeDashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Access denied.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Associate Log In'),
        backgroundColor: const Color(0xFF6F4E37), // Coffee theme color
        foregroundColor: const Color(0xFFF8F8FF), // Offwhite font color
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo and Header Section
                const Column(
                  children: [
                    SizedBox(height: 40),
                    LogoWidget(),
                    SizedBox(height: 10),
                     Associate(),
                  ],
                ),

                const SizedBox(height: 20), // Add space between header and input section

                // Input Section for Email and Password
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E6),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Column(
                    children: [
                      // Email input field
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Password input field
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Login button
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 176, 129, 79), // Font color
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
