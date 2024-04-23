import 'package:flutter/material.dart';
import 'dart:async';
import 'package:how_many_texas/ui/response_page.dart';
import 'package:how_many_texas/utils/colors.dart'; // Import async library for Future and Timer

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Start a timer that triggers after 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the ResponsePage after the delay and replace the current route
      // Prevents multiple instances of the HomePage being pushed onto the stack by the ResponsePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResponsePage()),
      );
    });

    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildHeaderText(),
        _showCowGraphic(),
        _buildFooterText(),
      ],
    ));
  }

  Expanded _buildFooterText() {
    return Expanded(
      child: Container(
        color: AppColors.backgroundColor,
        child: Center(
          child: Text(
            'Widget 3',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  Flexible _showCowGraphic() {
    return Flexible(
      flex: 3,
      child: Stack(
        children: [
          // Background Color
          Container(
            color: AppColors.backgroundColor, // Adjust opacity as needed
          ),

          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/cow_1_trimmed.png',
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildHeaderText() {
    return Expanded(
      child: Container(
        color: AppColors.backgroundColor,
        child: Center(
          child: Text(
            'Widget 1',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
