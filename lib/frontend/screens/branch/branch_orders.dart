import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/branch_nav_bar.dart'; // Import BranchNavBar
import 'package:kopilism/frontend/widgets/branch_top_nav_bar.dart'; // Import BranchTopNavBar
import 'package:kopilism/frontend/widgets/branch_sidebar.dart'; // Import BranchSidebar

class BranchOrders extends StatefulWidget {
  const BranchOrders({Key? key}) : super(key: key);

  @override
  _BranchOrdersState createState() => _BranchOrdersState();
}

class _BranchOrdersState extends State<BranchOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch Orders'),
      ),
      drawer: const BranchSidebar(), // Add the BranchSidebar here
      body: Column(
        children: [
          const BranchTopNavBar(), // Add BranchTopNavBar here
          Expanded(
            child: Center(
              child: Text('No orders available.'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BranchNavBar(), // Add BranchNavBar here
    );
  }
}
