import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/constants/asset_paths.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import 'package:how_many_texas/cubit/texas_calculator.dart';
import 'package:how_many_texas/how_many_texas.dart';
import 'package:how_many_texas/ui/common_widgets/helper_methods.dart';
import 'package:how_many_texas/ui/ui_exports.dart';
import '../../cubit/app_cubit.dart';
import '../common_widgets/image_button.dart';
import 'package:how_many_texas/constants/text_styles.dart';

class HowPage extends StatefulWidget {
  const HowPage({super.key});

  @override
  State<HowPage> createState() => _HowPageState();
}

class _HowPageState extends State<HowPage> {
  late SearchResult searchResult;
  late AppCubit appCubit;

  @override
  void initState() {
    appCubit = BlocProvider.of<AppCubit>(context);
    searchResult = appCubit.getCurrentSearchResult();
    super.initState();
  }

  // final SearchResult searchResult;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (backClicked) {
      //    appCubit.navToResponsePage();
      // },
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        appCubit.navToResponsePage();
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          // Makes the child as high as the device screen
          width: double.infinity,
          // Makes the child as wide as the device screen
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
        child: SingleChildScrollView(
          child: Transform.scale(
            scale: 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _textBody(),
                // _spacerBox(45),
                _arrowButtonRow(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _woodBackground() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AssetPaths.CHALKBOARD),
        // Replace 'assets/background_image.jpg' with your image path
        fit: BoxFit.fill, // Adjust the image fit as needed
      ),
    );
  }

  SizedBox _spacerBox(double height) {
    return SizedBox(width: double.infinity, height: height);
  }

  Stack _explanationBody() {
    return Stack(
      children: [
        Center(child: _paperBackGround()),
        Center(child: _ropePictureFrame()),
        Transform.translate(
            offset: const Offset(0, 10), child: Center(child: _textBody())),
      ],
    );
  }

  SizedBox _paperBackGround() {
    return const SizedBox(
      width: 350,
      height: 550,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        // Adjust the radius as needed
        child: Image(
          image: AssetImage(AssetPaths.PAPER_BACKGROUND),
          fit: BoxFit
              .fill, // Use BoxFit.fill to stretch the image to fit the box
        ),
      ),
    );
  }

  Widget _ropePictureFrame() {
    return SizedBox(
      width: 500,
      height: 600,
      child: Transform.translate(
        offset: const Offset(0, -20), // Adjust the x and y offset as needed
        child: const Image(
          image: AssetImage(AssetPaths.ROPE_FRAME),
          fit: BoxFit
              .fill, // Use BoxFit.fill to stretch the image to fit the box
        ),
      ),
    );
  }

  Center _textBody() {
    TexasCalculator texasCalculator = TexasCalculator();
    Map<String, dynamic> json = jsonDecode(searchResult.objectDimensionsResult);
    String objectName = searchResult.search;
    double objectArea = texasCalculator.calculateObjectAreaForHowPage(json);
    double texasArea = texasCalculator.getTexasArea();
    double objectToSquareMiles = double.parse(texasCalculator
        .convertToSquareMiles(objectArea, 'feet')
        .toStringAsFixed(10));
    String finalNumberWordsResult =
        searchResult.finalNumberWordsResult.capitalizeFirst();

    const spacerSize = 25.0;

    return Center(
      child: DefaultTextStyle(
        style: AppTextStyles.howPageBodyTextStyle,
        textAlign: TextAlign.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Math Time! ......',
              style: TextStyle(
                fontSize: 56, // Adjust this value to increase or decrease the text size
              ),
            ),
            const SizedBox(height: spacerSize),
            Text('1) The area of 1 $objectName = $objectArea square feet'),
            const SizedBox(height: spacerSize),
            Text('2) The area of Texas = $texasArea square miles'),
            const SizedBox(height:spacerSize),
            Text('3) Convert area of $objectName to square miles'),
            const SizedBox(height: spacerSize),
            Text('1 $objectName = $objectToSquareMiles square miles'),
            const SizedBox(height: spacerSize),
            Text('4) Divide the area of Texas by the area of $objectName'),
            const SizedBox(height: spacerSize),
            Text('5) $finalNumberWordsResult $objectName fit inside of Texas'),
          ],
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
      onPressed: () {
        appCubit.checkCreditsAndNavToCorrectPage();
      },
      image: const AssetImage(AssetPaths.BIG_RED_BUTTON),
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
        AssetPaths.ANGLED_ARROW,
        width: 120,
        height: 120,
      ),
    );
  }
}
