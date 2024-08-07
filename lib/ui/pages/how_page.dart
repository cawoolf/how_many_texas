import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import 'package:how_many_texas/cubit/texas_calculator.dart';
import '../../cubit/app_cubit.dart';
import '../common_widgets/image_button.dart';
import 'package:how_many_texas/constants/text_styles.dart';


class HowPage extends StatelessWidget {
  HowPage({super.key});
  late SearchResult searchResult;
  late AppCubit appCubit;

  // final SearchResult searchResult;
  // const HowPage({required this.searchResult,  super.key});

  @override
  Widget build(BuildContext context) {
    appCubit = BlocProvider.of<AppCubit>(context);
    searchResult = appCubit.getCurrentSearchResult();

    return PopScope(
      canPop: false,
      onPopInvoked: (backClicked) {
        _navToHomePage(context);
      },
      child: Scaffold(
        body: Container(
          height: double.infinity, // Makes the child as high as the device screen
          width: double.infinity, // Makes the child as wide as the device screen
          color: Colors.grey,
          child: _createBodyContent(context),
        ),
      ),
    );
  }

  SafeArea _createBodyContent(BuildContext context) {
    return SafeArea(
      // SafeArea keeps the child widgets from interacting with the OS UI
      child: Container(
        decoration: _woodBackground(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             _spacerBox(45),
             _explanationBody(),
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

  SizedBox _spacerBox(double height) {
    return SizedBox(width: double.infinity, height: height);
  }

  Stack _explanationBody() {
    return Stack(children: [
      Center(child: _paperBackGround()),
      Center(child: _ropePictureFrame()),
      Center(child: _textBody()),
    ],);
  }

  SizedBox _paperBackGround() {
    return const SizedBox(
      width: 350,
      height: 525,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)), // Adjust the radius as needed
        child: Image(
          image: AssetImage('assets/paper_background.png'),
          fit: BoxFit.fill, // Use BoxFit.fill to stretch the image to fit the box
        ),
      ),
    );
  }

  Widget _ropePictureFrame() {
    return SizedBox(
      width: 500,
      height: 570,
      child: Transform.translate(
        offset: const Offset(0, -15), // Adjust the x and y offset as needed
        child: const Image(
          image: AssetImage('assets/rope_frame.png'),
          fit: BoxFit.fill, // Use BoxFit.fill to stretch the image to fit the box
        ),
      ),
    );
  }

  SizedBox _textBody() {
    TexasCalculator texasCalculator = TexasCalculator();
    Map<String, dynamic> json = jsonDecode(searchResult.objectDimensionsResult);
    String objectArea = texasCalculator.calculateObjectAreaForHowPage(json);

    return SizedBox(
      width: 300,
      height: 500, // Adjust the height as needed
      child: Center(
        child: DefaultTextStyle(
          style: AppTextStyles.howPageBodyTextStyle,
          textAlign: TextAlign.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('1) The area of 1 ${searchResult.search} = $objectArea'),
              Text('2) The area of Texas = ${texasCalculator.getTexasArea()} square miles'),
              Text('3) Convert area of ${searchResult.search} to square miles'),
              Text('4) Divide the area of Texas by the area of ${searchResult.search}'),
              Text('5) Result! = ${searchResult.finalNumberResult}'),
            ],
          ),
        ),
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

  ImageButton _bigRedButton(BuildContext context) {
    return ImageButton(
      // Navigation isn't considered UI. How to abstract this away?
      onPressed: () {
        _navToMoneyScreen(context);
      },

      image: const AssetImage('assets/big_red_button.png'),
      height: 125,
      width: 175,
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

  // Navigation

  void _navToMoneyScreen(BuildContext context) {
    // final appCubit = BlocProvider.of<AppCubit>(context);
    int currentCredits = appCubit.getCredits();
    // print(credits);
    currentCredits = 0; // Just for testing
    if(currentCredits == 0) {

      appCubit.navToMoneyPage(currentCredits);

    }
    else {
      appCubit.navToHomePage();
    }
  }

  void _navToHomePage(BuildContext context) {
    // final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.navToHomePage();

  }



}
