import 'package:flutter/material.dart';


import 'dart:async';

import 'package:how_many_texas/ui/response_page.dart'; // Import async library for Future and Timer

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Start a timer that triggers after 2 seconds
    Timer(Duration(seconds: 2), () {
      // Navigate to the ResponsePage after the delay
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResponePage()),
      );
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator in the center
      ),
    );
  }
}
