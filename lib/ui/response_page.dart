import 'package:flutter/material.dart';
import 'package:how_many_texas/ui/home_page.dart';
import 'common_widgets/image_button.dart';
import 'package:how_many_texas/utils/text_styles.dart';

import 'common_widgets/rotated_image.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({super.key});

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
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wood_floors_3.png'),
                // Replace 'assets/background_image.jpg' with your image path
                fit: BoxFit.cover, // Adjust the image fit as needed
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('You can fit...',
                    style: AppTextStyles.welcomePageTextStyle,
                    textAlign: TextAlign.center),
                _resultsColumn(),
                Text('Inside of Texas!',
                    style: AppTextStyles.homeTextStyle,
                    textAlign: TextAlign.center),
                _texasImage(),
               _arrowButtonRow(context)
              ],
            ),
          ),
        ),
      ],
    ));
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

  Widget _texasImage() {
    return const Image(
        image: AssetImage('assets/texas_1_trimmed.png'),
    width: 200,
    height: 200,);
  }
  Widget _resultsColumn() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   'assets/rattlesnake_1.png',
              //   width: 100,
              //   height: 100,
              // ),
              RotatedImage(imagePath: 'assets/rattlesnake_1.png',
                  width: 100,
                  height: 100,
                  rotation: 0.45),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('100000000',
                    style: AppTextStyles.homeTextStyle,
                    textAlign: TextAlign.center)],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rattlesnakes',
                  style: AppTextStyles.homeTextStyle,
                  textAlign: TextAlign.center),
              Image.asset(
                'assets/rattlesnake_1.png',
                width: 100,
                height: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
