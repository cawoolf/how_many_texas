import 'package:flutter/material.dart';
import 'dart:async';
import 'package:how_many_texas/ui/response_page.dart'; // Import async library for Future and Timer
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});


  @override
  Widget build(BuildContext context) {
    // Start a timer that triggers after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the ResponsePage after the delay and replace the current route
      // Prevents multiple instances of the HomePage being pushed onto the stack by the ResponsePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResponsePage()),
      );
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator in the center
      ),
    );
  }
}
