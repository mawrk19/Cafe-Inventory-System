import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';
import 'package:kopilism/backend/services/customers_service.dart';
import 'package:kopilism/frontend/widgets/customers_card.dart';
import 'package:kopilism/frontend/screens/admin/customer_details.dart';

class AdminCustomers extends StatefulWidget {
  const AdminCustomers({super.key});

  @override
  State<AdminCustomers> createState() => _AdminCustomersState();
}

class _AdminCustomersState extends State<AdminCustomers> {
  final CustomersService _customersService = CustomersService();
  List<Map<String, dynamic>> _customers = [];

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    final customers = await _customersService.getAllCustomers();
    setState(() {
      _customers = customers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _customers.isEmpty
            ? const Center(child: Text('No customers available'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: _customers.length,
                itemBuilder: (context, index) {
                  final customer = _customers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerDetailsScreen(customer: customer),
                        ),
                      );
                    },
                    child: CustomersCard(
                      branchNumber: customer['branchNumber'],
                      city: customer['city'],
                      region: customer['region'],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRegisterCustomerDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  void _showRegisterCustomerDialog(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController contactNumberController = TextEditingController();
    final TextEditingController branchNumberController = TextEditingController();
    final TextEditingController regionController = TextEditingController();
    final TextEditingController provinceController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController baranggayController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController ownerInformationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Customer'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: contactNumberController,
                  decoration: const InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: branchNumberController,
                  decoration: const InputDecoration(labelText: 'Branch Number'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: regionController,
                  decoration: const InputDecoration(labelText: 'Region'),
                ),
                TextField(
                  controller: provinceController,
                  decoration: const InputDecoration(labelText: 'Province'),
                ),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: baranggayController,
                  decoration: const InputDecoration(labelText: 'Baranggay'),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: ownerInformationController,
                  decoration: const InputDecoration(labelText: 'Owner Information'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // Validate email format
                final email = emailController.text.trim();
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                if (!emailRegex.hasMatch(email)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Invalid email format'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                // Validate password length
                if (passwordController.text.trim().length < 6) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Password must be at least 6 characters long'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                // Validate all fields are filled
                if (fullNameController.text.trim().isEmpty || 
                    email.isEmpty || 
                    passwordController.text.trim().isEmpty || 
                    contactNumberController.text.trim().isEmpty || 
                    branchNumberController.text.trim().isEmpty || 
                    regionController.text.trim().isEmpty || 
                    provinceController.text.trim().isEmpty || 
                    cityController.text.trim().isEmpty || 
                    baranggayController.text.trim().isEmpty || 
                    addressController.text.trim().isEmpty || 
                    ownerInformationController.text.trim().isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('All fields are required'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                try {
                  await _customersService.registerCustomer(
                    ownerName: fullNameController.text.trim(),
                    ownerInformation: ownerInformationController.text.trim(),
                    email: email,
                    password: passwordController.text.trim(),
                    contactNumber: contactNumberController.text.trim(),
                    branchNumber: branchNumberController.text.trim(),
                    dateEstablished: DateTime.now(),
                    region: regionController.text.trim(),
                    province: provinceController.text.trim(),
                    city: cityController.text.trim(),
                    baranggay: baranggayController.text.trim(),
                    address: addressController.text.trim(),
                  );

                  Navigator.of(context).pop(); // Close dialog
                  _fetchCustomers(); // Refresh the customers list

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Customer successfully added'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  debugPrint('Error in _showRegisterCustomerDialog: $e');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text('Error: $e'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
