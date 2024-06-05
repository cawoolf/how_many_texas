import 'package:flutter/material.dart';
import 'package:how_many_texas/utils/colors.dart';
import 'package:how_many_texas/utils/text_styles.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Not UI
    // _delayedNavToResponsePage(context);

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
      ),
    );
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
}

