import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('No orders available.'),
      ),
    );
  }
}
