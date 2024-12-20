import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/branchHome/menu_carousel.dart';
import 'package:kopilism/frontend/widgets/branchHome/recent_orders.dart';
import 'package:kopilism/frontend/widgets/branch_nav_bar.dart';
import 'package:kopilism/frontend/widgets/branch_top_nav_bar.dart'; // Import BranchTopNavBar
import 'package:kopilism/frontend/widgets/branch_sidebar.dart'; // Import BranchSidebar

class BranchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        drawer: const BranchSidebar(), // Add the BranchSidebar here
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: Column(
              children: [
                const BranchTopNavBar(), // Add BranchTopNavBar here
                // SearchBar(screenWidth: screenWidth),
                SizedBox(height: screenHeight * 0.02),
                CategoryTabs(screenWidth: screenWidth),
                SizedBox(height: screenHeight * 0.02),
                CoffeeCarousel(),
                SizedBox(height: screenHeight * 0.02),
                RecentOrders(),
                SizedBox(height: screenHeight * 0.02),
                BranchNavBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SearchBar extends StatelessWidget {
//   final double screenWidth;

//   SearchBar({required this.screenWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Image.asset(
//           'assets/images/hamburgerIcon.png',
//           width: screenWidth * 0.07,
//           errorBuilder: (context, error, stackTrace) {
//             return Icon(Icons.menu);
//           },
//         ),
//         SizedBox(width: screenWidth * 0.03),
//         Image.asset(
//           'assets/images/SearchBar.png',
//           width: 227.69,
//           height: 49.63,
//           errorBuilder: (context, error, stackTrace) {
//             return Icon(Icons.search);
//           },
//         ),
//         SizedBox(width: screenWidth * 0.03),
//         Image.asset(
//           'assets/filterIcon.png',
//           width: screenWidth * 0.1,
//           errorBuilder: (context, error, stackTrace) {
//             return Icon(Icons.filter_alt);
//           },
//         ),
//         SizedBox(width: screenWidth * 0.03),
//         Image.asset(
//           'assets/images/notifications.png',
//           width: screenWidth * 0.1,
//           errorBuilder: (context, error, stackTrace) {
//             return Icon(Icons.notifications);
//           },
//         ),
//       ],
//     );
//   }
// }

class CategoryTabs extends StatelessWidget {
  final double screenWidth;

  CategoryTabs({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTab('All', true),
          SizedBox(width: screenWidth * 0.04),
          _buildTab('Coffee', false),
          SizedBox(width: screenWidth * 0.04),
          _buildTab('Cream', false),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.08,
        vertical: screenWidth * 0.02,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF753D29) : Color(0xFFFFF4E6),
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: Colors.black) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Color(0xFFFFF4E6) : Colors.black,
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}