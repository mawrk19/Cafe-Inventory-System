import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/SalesReport/table.dart';
import 'package:kopilism/frontend/widgets/SalesReport/sales_items.dart';
import 'package:kopilism/frontend/widgets/SalesReport/tab.dart'; // Import the InventoryTabs component
import 'package:kopilism/frontend/widgets/SalesReport/header_section.dart'; // Import the Header component
import 'package:kopilism/frontend/widgets/branch_nav_bar.dart';
import 'package:kopilism/frontend/widgets/branch_sidebar.dart';

class ProductSalesReport extends StatefulWidget {
  const ProductSalesReport({super.key});

  @override
  _ProductSalesReportState createState() => _ProductSalesReportState();
}

class _ProductSalesReportState extends State<ProductSalesReport> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey, // Assign the scaffold key to the Scaffold widget
      backgroundColor: Colors.white,
      drawer: const BranchSidebar(), // Your drawer
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: screenWidth * 0.95),
              padding: const EdgeInsets.only(top: 41),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Now HeaderSection can be const because scaffoldKey is constant within the StatefulWidget
                  HeaderSection(scaffoldKey: scaffoldKey),
                  const SizedBox(height: 20),
                  // Tabs
                  SizedBox(
                    width: double.infinity, // Ensures the tabs take full width
                    child: InventoryTabs(),
                  ),
                  const SizedBox(height: 20),
                  // Table
                  InventoryTable(),
                  const SizedBox(height: 20),
                  // Items
                  InventoryItems(),
                  const SizedBox(height: 20),
                  // Navigation Bar
                  BranchNavBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}