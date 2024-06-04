import 'package:flutter/material.dart';
import 'package:how_many_texas/ui/home_page.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                  Text(
                  'You can fit..',
                  style: AppTextStyles.welcomePageTextStyle,
                  textAlign: TextAlign.center),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _resultsImage(
                    imagePath: testImagePath,
                    width: 150.0,
                    height: 150.0,
                    rotation: -25.0),
                    _resultsImage(
                      imagePath: testImagePath,
                      width: 150.0,
                      height: 150.0,
                      rotation: 25.0,
                  ),
                ],
              ),
                  _resultsNumber(),
                  _searchText(),
              Text(
                  'Inside of Texas',
                  style: AppTextStyles.welcomePageTextStyle,
                  textAlign: TextAlign.center),
              _texasFlag(),
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
          padding: EdgeInsets.fromLTRB(0, 0, 0,48),
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
        width: 100,
        height: 100,
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
      height: 150,
      width: 200,
    );
  }

  // Not UI
  void _navToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  Widget _resultsImage({required imagePath,required double width,required double height, required rotation}) {
    return RotatedImage(
        imagePath: imagePath, width: width, height: height, rotation: rotation);
  }

  Widget _resultsNumber() {
    return Text('10000',
        style: AppTextStyles.welcomePageTextStyle,
        textAlign: TextAlign.center);
  }

  Widget _searchText() {
    return Text('Rattlesnakes',
        style: AppTextStyles.homeTextStyle,
        textAlign: TextAlign.center);
  }

  SizedBox _texasFlag() {
    return SizedBox(
      height: 150,
      child: Image.asset('assets/texas_flag_wavy_trimmed.png',// Adjust the fit as needed
      ),
    );
  }
}
