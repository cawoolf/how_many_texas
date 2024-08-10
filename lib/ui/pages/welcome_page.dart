import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/constants/text_styles.dart';

import '../../cubit/app_cubit.dart';
import '../../constants/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final appCubit = BlocProvider.of<AppCubit>(context);
    checkCredits(appCubit);


    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: _backgroundColor(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _welcomeText1(),
                _welcomeText2(),
                _showCowBoyGraphic()
              ],
            ),
          )),
    );
  }

  Text _welcomeText1() {
    return Text('How Many', style: AppTextStyles.welcomePageTextStyle);
  }

  Text _welcomeText2() {
    return Text('Texas?', style: AppTextStyles.welcomePageTextStyle);
  }

  BoxDecoration _backgroundColor() {
    return const BoxDecoration(color: AppColors.backgroundColor);
  }

  Flexible _showCowBoyGraphic() {
    return Flexible(
      flex: 3,
      child: Stack(
        children: [
          // Background Color
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/cowboy_1.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  void checkCredits(AppCubit appCubit) {
    int credits = appCubit.getCredits();
    print('welcome_page.dart line 66 -> credits = $credits');
    if(credits <= 0) {
      appCubit.navToMoneyPageDelayed(credits);
    }
    else {
      appCubit.navToHomePageDelayed();
    }
  }


}
