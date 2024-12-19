import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/dashboard/stock_chart.dart';
import 'package:kopilism/frontend/widgets/dashboard/popular_items.dart';
import 'package:kopilism/frontend/widgets/dashboard/low_stock_item.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart'; // Add this import
import 'package:kopilism/frontend/widgets/sidebar.dart'; // Add this import

class EmployeeDashboard extends StatelessWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white, // Set background color to white
      appBar: const TopNavBar(), // Add TopNavBar here
      drawer: const Sidebar(), // Add Sidebar here
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(11, 20, 11, 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 39),
                  child: Text(
                    'Stock Levels',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 19),
                const StockChart(),
                const SizedBox(height: 29),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 39),
                  child: Text(
                    'Most Popular',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 11),
                const PopularItems(),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 39),
                  child: Text(
                    'Low Stock Alert',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 11),
                const LowStockItems(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:  BottomNavBar(),
    );
  }
}
