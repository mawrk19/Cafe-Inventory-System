import 'package:flutter/material.dart';
import '../frontend/screens/admin_category.dart';
import '../frontend/screens/admin_barcode.dart';
import '../frontend/screens/admin_customers.dart';
import '../frontend/screens/admin_dashboard.dart';
import '../frontend/screens/admin_orders.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return{
    '/AdminCategory': (context) => const AdminCategory(),
    '/Customer': (context) => const AdminCustomers(),
    '/Barcode': (context) => const AdminBarcode(),
    '/Home': (context) => const AdminDashboard(),
    '/Orders': (context) => const AdminOrders(),  
  };
}