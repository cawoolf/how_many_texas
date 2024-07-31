import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/how_many_texas.dart';
import '../cubit/app_cubit.dart';
import 'common_widgets/image_button.dart';
import 'package:how_many_texas/constants/text_styles.dart';

import 'home_page.dart';

class MoneyPage extends StatelessWidget {
  final int credits;

  const MoneyPage({super.key, required this.credits});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity, // Makes the child as high as the device screen
        width: double.infinity, // Makes the child as wide as the device screen
        color: Colors.grey,
        child: _createBodyContent(context),
      ),
    );
  }

  SafeArea _createBodyContent(BuildContext context) {
    return SafeArea(
      // SafeArea keeps the child widgets from interacting with the OS UI
      child: Container(
        decoration: _woodBackground(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Ad Plays',
                style: AppTextStyles.homeTextStyle,
                textAlign: TextAlign.center),

            Text('Or you pays',
                style: AppTextStyles.homeTextStyle,
                textAlign: TextAlign.center),
            // _texasFlag(),
            _arrowButtonRow(context)
          ],
        ),
      ),
    );
  }

  BoxDecoration _woodBackground() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/wood_floors_3.png'),
        // Replace 'assets/background_image.jpg' with your image path
        fit: BoxFit.fill, // Adjust the image fit as needed
      ),
    );
  }

  Row _arrowButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
          child: _bigRedButton(context),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 48),
          child: _bigRedArrow(rotation: 0),
        ),
      ],
    );
  }

  Transform _bigRedArrow({required double rotation}) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(rotation * 3.1415927 / 180)
        ..rotateZ(180 * 3.1415927 / 180)
        ..scale(1.0, -1.0), // Flip horizontally
      child: Image.asset(
        'assets/arrow_1_trimmed.png',
        width: 120,
        height: 120,
      ),
    );
  }

  ImageButton _bigRedButton(BuildContext context) {
    return ImageButton(
      // Navigation isn't considered UI. How to abstract this away?
      onPressed: () {
        _navToHomePage(context);
      },
      key: const Key("home_button"),
      image: const AssetImage('assets/big_red_button.png'),
      height: 125,
      width: 175,
    );
  }

  // Not UI
  void _navToHomePage(BuildContext context) {

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HowManyTexas()),
        (Route<dynamic> route) => false);

    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.setHomePageState();

  }
}
