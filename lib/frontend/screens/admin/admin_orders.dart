import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/orders/order_list.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/search_bar2.dart' as custom;
import 'package:kopilism/frontend/widgets/sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';

class AdminOrders extends StatelessWidget {
  const AdminOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(), // Use the custom TopNavBar
      drawer: const Sidebar(), // Add the Sidebar as the drawer
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // custom.SearchBar(),
              custom.SearchBar2(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Order No.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Spacer(flex: 3,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(), // Add padding to OrderItemList
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(),
              ),
               Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(), // Add padding to OrderItemList
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(),
              ),
               Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(), // Add padding to OrderItemList
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(),
              ),
               Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(), // Add padding to OrderItemList
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(),
              ),
               Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(), // Add padding to OrderItemList
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(),
              ),
               Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(), // Add padding to OrderItemList
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: OrderItemList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}