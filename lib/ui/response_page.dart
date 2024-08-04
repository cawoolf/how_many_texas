import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import '../cubit/app_cubit.dart';
import 'common_widgets/image_button.dart';
import 'package:how_many_texas/constants/text_styles.dart';


class ResponsePage extends StatelessWidget {
  final Image searchImage;
  final SearchResult searchResult;


  const ResponsePage(
      {required this.searchImage,
      required this.searchResult,
      super.key});

  @override
  Widget build(BuildContext context) {
    _playTTSAudio(searchResult.TTS_PATH, context);

    return PopScope(
      canPop: false,
      onPopInvoked: (backClicked) {
        _navToHomePage(context);
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          // Makes the child as high as the device screen
          width: double.infinity,
          // Makes the child as wide as the device screen
          color: Colors.grey,
          child: _createBodyContent(context, searchImage),
        ),
      ),
    );
  }

  SafeArea _createBodyContent(
      BuildContext context, Image searchImage) {
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
            _resultsNumber(),
            Transform.translate(offset: const Offset(0, -25),
            child: _searchText()),
            _resultsImageRow(searchImage),
            const SizedBox(height: 15.0),
            Text('Inside of Texas!',
                style: AppTextStyles.homeTextStyle,
                textAlign: TextAlign.center),
            // _texasFlag(),
            _arrowButtonRow(context)
          ],
        ),
      ),
    );
  }

  Row _resultsImageRow(Image searchImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Transform.translate(
          offset: const Offset(0, -15),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _resultsImage(searchImage: searchImage),
              _ropePictureFrame(),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox _ropePictureFrame() {
    return const SizedBox(
      width: 325.0, // Adjust width to match the frame image
      height: 300.0, // Adjust height to match the frame image
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image(
          image: AssetImage('assets/rope_frame.png'),
        ),
      ),
    );
  }

  SizedBox _resultsImage({required Image searchImage}) {
    return SizedBox(
      width: 300, // Set the width of the square
      height: 325, // Set the height of the square
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        // Optional: For rounded corners
        child: searchImage,
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
        _navToHowPage(context);
      },
      key: const Key("home_button"),
      image: const AssetImage('assets/big_red_button.png'),
      height: 125,
      width: 175,
    );
  }

  // Not UI
  void _navToHomePage(BuildContext context) {
    // Navigator.popUntil(context, (route) => route.isFirst);
    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.navToHomePage();
  }

  void _navToHowPage(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.navToHowPage();
  }

  void _playTTSAudio(String ttsFilePath, BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.playNumbersAudio(ttsFilePath);
  }


  Widget _resultsNumber() {
    // TexasCalculator texasCalculator = TexasCalculator();
    return Text(
        searchResult.finalNumberResult,
        style: AppTextStyles.welcomePageTextStyle,
        textAlign: TextAlign.center);
  }

  Widget _searchText() {
    return Text(searchResult.search,
        style: AppTextStyles.welcomePageTextStyle, textAlign: TextAlign.center);
  }

}
