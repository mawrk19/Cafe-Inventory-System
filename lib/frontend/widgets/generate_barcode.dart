import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';

class BarcodeGeneratorComponent extends StatefulWidget {
  const BarcodeGeneratorComponent({super.key});

  @override
  BarcodeGeneratorComponentState createState() =>
      BarcodeGeneratorComponentState();
}

class BarcodeGeneratorComponentState extends State<BarcodeGeneratorComponent> {
  final TextEditingController _skuController = TextEditingController();
  final GlobalKey _barcodeKey = GlobalKey();

  Future<void> _saveBarcode() async {
    try {
      RenderRepaintBoundary boundary = _barcodeKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getApplicationDocumentsDirectory()).path;
      final imgFile = File('$directory/barcode.png');
      await imgFile.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Barcode saved to $directory/barcode.png')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save barcode')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate SKU Barcode'),
         automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _skuController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter SKU',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          RepaintBoundary(
            key: _barcodeKey,
            child: BarcodeWidget(
              barcode: Barcode.code128(),
              data: _skuController.text,
              width: 250,
              height: 250,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveBarcode,
            child: Text('Save Barcode'),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
