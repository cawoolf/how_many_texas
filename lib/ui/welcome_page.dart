import 'package:flutter/material.dart';
import 'package:how_many_texas/utils/text_styles.dart';

import 'home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});


  @override
  Widget build(BuildContext context) {
    // Start a timer that triggers after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the HomePage after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    return Scaffold(
      body: Center(
        child: Text(
          'How Many Texas?',
          style: AppTextStyles.yeehawHeading
        ),
      ),
    );
  }
}