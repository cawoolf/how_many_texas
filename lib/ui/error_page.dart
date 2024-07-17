import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/constants/colors.dart';
import 'package:how_many_texas/constants/text_styles.dart';
import 'package:how_many_texas/ui/home_page.dart';

import '../cubit/app_cubit.dart';


class ErrorPage extends StatelessWidget {

  final String error;
  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {

    // Not UI
    _logErrorMsg(error);
    _navToHomePageDelayed(context);

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
          'Woops..',
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
              'assets/cow_skull_edited.png',
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
          'Try that again partner..',
          style: AppTextStyles.loadingPageFooterTextStyle,
        ),
      ),
    );
  }

  BoxDecoration _backgroundColor() {
    return const BoxDecoration(color: AppColors.backgroundColor);
  }

  void _logErrorMsg(String errorMsg) {
    log(errorMsg);
  }

  void _navToHomePageDelayed (BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.navToHomePageDelayed();
  }
}
