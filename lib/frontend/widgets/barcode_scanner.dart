import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState(); // Fixed state class name
}

class _BarcodeScannerState extends State<BarcodeScanner> { // Fixed state class name
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                returnImage: true,
                formats: [BarcodeFormat.all],
              ),
              onDetect: (capture) async {
                if (_isProcessing) return;

                setState(() {
                  _isProcessing = true;
                });

                final barcodes = capture.barcodes;
                final Uint8List? image = capture.image;

                if (barcodes.isNotEmpty) {
                  final barcode = barcodes.first;

                  print('Barcode: ${barcode.rawValue}');

                  if (image != null) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(barcode.rawValue ?? ""),
                          content: Image.memory(image),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }

                setState(() {
                  _isProcessing = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
