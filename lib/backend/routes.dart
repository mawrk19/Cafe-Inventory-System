import 'package:flutter/material.dart';
import 'package:kopilism/frontend/screens/employee/employee_dashboard.dart';
import 'package:kopilism/frontend/screens/employee/employee_barcode.dart';
import 'package:kopilism/frontend/screens/employee/employee_customers.dart';
import 'package:kopilism/frontend/screens/employee/employee_orders.dart';
import '../frontend/screens/admin/products/admin_category.dart';
import '../frontend/screens/admin/admin_barcode.dart';
import '../frontend/screens/admin/admin_customers.dart';
import '../frontend/screens/admin/admin_dashboard.dart';
import '../frontend/screens/admin/admin_orders.dart';
import '../frontend/screens/admin/admin_login.dart';
import '../frontend/screens/branch/branch_login.dart';
import '../frontend/screens/registration.dart';
import '../frontend/screens/employee/products/employee_category.dart';
import '../frontend/screens/branch/branch_notifications.dart';
import '../frontend/screens/branch/branch_history.dart';
import '../frontend/screens/branch/branch_home.dart';
import '../frontend/screens/branch/branch_category.dart';
import '../frontend/screens/branch/branch_orders.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    //bottom navigation bar for admins
    '/AdminCategory': (context) => const AdminCategory(),
    '/Customer': (context) => const AdminCustomers(),
    '/Barcode': (context) => const AdminBarcode(),
    '/Home': (context) => AdminDashboard(),
    '/Orders': (context) => const AdminOrders(),

    '/EmployeeCategory': (context) => const EmployeeCategory(),
    '/EmployeeCustomer': (context) => const EmployeeCustomers(),
    '/EmployeeBarcode': (context) => const EmployeeBarcode(),
    '/EmployeeHome': (context) => EmployeeDashboard(),
    '/EmployeeOrders': (context) => const EmployeeOrders(),
    //login and registration
    '/AdminLogIn': (context) => const AdminLogin(),
    '/BranchLogIn': (context) => const BranchLogin(
          role: 'branch',
        ),
    '/Registration': (context) => const RegistrationForm(),
    //branch routes
    '/BranchNotifications': (context) => const BranchNotifications(),
    '/BranchHistory': (context) => const BranchHistory(),
    '/BranchHome': (context) => BranchHome(),
    '/BranchCategory': (context) => const BranchCategory(),
    '/BranchOrders': (context) => const BranchOrders(),
  };
}
