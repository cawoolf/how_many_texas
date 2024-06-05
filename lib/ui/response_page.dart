import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/ui/home_page.dart';
import '../cubit/app_cubit.dart';
import 'common_widgets/image_button.dart';
import 'package:how_many_texas/utils/text_styles.dart';

import 'common_widgets/rotated_image.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({super.key});

  static const String testImagePath = 'assets/rattlesnake_1.png';

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
            Text('You can fit..',
                style: AppTextStyles.homeTextStyle,
                textAlign: TextAlign.center),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.translate(offset: Offset(0,-50),
                  child: _resultsImage(
                      imagePath: testImagePath,
                      width:175.0,
                      height: 175.0,
                      rotation: -25.0),
                ),
                Transform.translate(
                  offset: Offset(-25,25),
                  child: _resultsImage(
                    imagePath: testImagePath,
                    width: 175.0,
                    height: 175.0,
                    rotation: 25.0,
                  ),
                ),
                // _resultsImage(
                //   imagePath: testImagePath,
                //   width: 150.0,
                //   height: 150.0,
                //   rotation: 25.0,
                // ),
              ],
            ),
                _resultsNumber(),
            _searchText(),
            Text('Inside of Texas',
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
          padding: EdgeInsets.fromLTRB(32.0, 0, 0, 0),
          child: _bigRedButton(context),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 48),
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
      image: AssetImage('assets/big_red_button.png'),
      height: 125,
      width: 175,
    );
  }

  // Not UI
  void _navToHomePage(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.loadHomePage();
  }

  Widget _resultsImage(
      {required imagePath,
      required double width,
      required double height,
      required rotation}) {
    return RotatedImage(
        imagePath: imagePath, width: width, height: height, rotation: rotation);
  }

  Widget _resultsNumber() {
    return Text('123466789123',
        style: AppTextStyles.welcomePageTextStyle, textAlign: TextAlign.center);
  }

  Widget _searchText() {
    return Text('Rattlesnakes',
        style: AppTextStyles.welcomePageTextStyle, textAlign: TextAlign.center);
  }

  SizedBox _texasFlag() {
    return SizedBox(
      height: 125,
      child: Image.asset(
        'assets/texas_flag_wavy_trimmed.png', // Adjust the fit as needed
      ),
    );
  }
}
