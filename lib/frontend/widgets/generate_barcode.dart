import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
class BarcodeGeneratorComponent extends StatefulWidget {
  const BarcodeGeneratorComponent({super.key});

  @override
  BarcodeGeneratorComponentState createState() => BarcodeGeneratorComponentState();
}

class BarcodeGeneratorComponentState extends State<BarcodeGeneratorComponent> {
  final TextEditingController _skuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate SKU Barcode'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _skuController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter SKU',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          BarcodeWidget(
            barcode: Barcode.code128(),
            data: _skuController.text,
            width: 400,
            height: 400,
          ),
        ],
      ),
    );
  }
}