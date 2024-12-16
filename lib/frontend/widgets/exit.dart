import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemNavigator

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Exit"),
        content: const Text("Do you really want to exit?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // No
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop(); // Close the app
            },
            child: const Text("Yes"),
          ),
        ],
      );
    },
  ) ?? false; // Return false if dialog is dismissed
}
