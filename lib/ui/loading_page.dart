import 'package:flutter/material.dart';
import 'dart:async';
import 'package:how_many_texas/ui/response_page.dart';
import 'package:how_many_texas/utils/colors.dart';
import 'package:how_many_texas/utils/text_styles.dart'; // Import async library for Future and Timer

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Not UI
    _delayedNavToResponsePage(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: _backgroundColor(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHeaderText(),
              _showCowGraphic(),
              _buildFooterText()
            ],
          ),
        ),
      ));
  }

  void _delayedNavToResponsePage(BuildContext context) {
       Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the ResponsePage after the delay and replace the current route
      // Prevents multiple instances of the HomePage being pushed onto the stack by the ResponsePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResponsePage()),
      );
    });
  }

  Expanded _buildHeaderText() {
    return Expanded(
      child: Center(
        child: Text(
          'Loading..',
          style: AppTextStyles.loadingPageHeaderTextStyle,
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

  Expanded _buildFooterText() {
    return Expanded(
      child: Center(
        child: Text(
          'AI Cow is thinking!',
          style: AppTextStyles.loadingPageFooterTextStyle,
        ),
      ),
    );
  }

  BoxDecoration _backgroundColor() {
    return const BoxDecoration(color: AppColors.backgroundColor);
  }

  //Test
}
