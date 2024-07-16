
import 'package:flutter/material.dart';

GestureDetector _inputTextDialog(BuildContext context) {
  return  GestureDetector(
    onTap: () {
      _showInputDialog(context); // Call the method to show the input dialog
    },
    child: Container(
      padding: const EdgeInsets.all(10), // Adjust padding as needed
      decoration: BoxDecoration(
        border: Border.all(), // Add border for better visual cue
        borderRadius: BorderRadius.circular(5), // Optional: Add border radius
      ),
      child: const Text(
        'Click here to enter text', // Hint or custom message
        style: TextStyle(color: Colors.grey), // Optional: Adjust text color
      ),
    ),
  );
}

Future<void> _showInputDialog(BuildContext context) async {
  String userInput = await showDialog(
    context: context,
    builder: (BuildContext context) {
      String text = ''; // Initial value of the input field
      return AlertDialog(
        title: const Text('Enter Text'),
        content: TextField(
          onChanged: (value) {
            text = value; // Update the text variable when input changes
          },
          decoration: const InputDecoration(
            hintText: 'Enter text...',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(text); // Close dialog and return text
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
  print('User Input: $userInput'); // Do something with the user input
}
