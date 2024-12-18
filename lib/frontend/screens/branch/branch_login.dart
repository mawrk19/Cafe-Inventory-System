import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/authentication.dart';
import 'package:kopilism/frontend/screens/branch/branch_home.dart';

class BranchLogin extends StatefulWidget {
  final String role;

  const BranchLogin({super.key, required this.role});

  @override
  _BranchLoginState createState() => _BranchLoginState();
}

class _BranchLoginState extends State<BranchLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthenticationService _authService = AuthenticationService();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = await _authService.login(
          _emailController.text,
          _passwordController.text,
        );

        if (user != null) {
          DocumentSnapshot userDoc = await _authService.getUserData(user.uid);
          var userData = userDoc.data() as Map<String, dynamic>;

          if (userData['role'] == 'branch') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BranchDashboard()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Access denied.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not found.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.role == 'branch') {
      return BranchHome();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Branch Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_emailController.text.isNotEmpty) {
                      await _authService
                          .sendPasswordResetEmail(_emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Password reset email sent')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please enter your email')),
                      );
                    }
                  },
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class BranchDashboard extends StatelessWidget {
  const BranchDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Branch Dashboard'),
      ),
      body: const Center(
        child: Text('Welcome to the Branch Dashboard!'),
      ),
    );
  }
}

// ...existing code...
