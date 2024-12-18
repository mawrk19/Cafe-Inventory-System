import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/employee_bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/employee_sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';
import 'package:kopilism/frontend/widgets/barcode_scanner.dart';

class EmployeeBarcode extends StatelessWidget {
  const EmployeeBarcode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(), // Use the custom TopNavBar
        drawer: const EmployeeSidebar(), 
      body: Center(
        child: Row (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BarcodeScanner()),
                  );
                },
                child: Text('Scan Barcode', textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const EmployeeBottomNavBar(), // Use your custom widget  
    );
  }
}
