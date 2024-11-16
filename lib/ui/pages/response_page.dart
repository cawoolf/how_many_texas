import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/constants/asset_paths.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import '../../cubit/app_cubit.dart';
import '../common_widgets/helper_methods.dart';
import '../common_widgets/image_button.dart';
import 'package:how_many_texas/constants/text_styles.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({super.key});

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  late SearchResult searchResult;
  late AppCubit appCubit;

  @override
  void initState() {
    super.initState();
    appCubit = BlocProvider.of<AppCubit>(context);
    searchResult = appCubit.getCurrentSearchResult();
    appCubit.playNumbersAudio(searchResult.TTS_PATH);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (backClicked) {
      //   appCubit.checkCreditsAndNavToCorrectPage();
      // },
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        appCubit.checkCreditsAndNavToCorrectPage();
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          // Makes the child as high as the device screen
          width: double.infinity,
          // Makes the child as wide as the device screen
          color: Colors.grey,
          child: _createBodyContent(context, searchResult.searchImage),
        ),
      ),
    );
  }

  SafeArea _createBodyContent(BuildContext context, Image searchImage) {
    return SafeArea(
      // SafeArea keeps the child widgets from interacting with the OS UI
      child: Container(
        decoration: _woodBackground(),
        child: SingleChildScrollView(
          child: Transform.scale(
            scale: 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _topTextRow(),
                _resultsNumber(),
                Transform.translate(
                    offset: const Offset(0, -25), child: _searchText()),
                _resultsImageRow(searchImage),
                const SizedBox(height: 15.0),
                Text('Inside of Texas!',
                    style: AppTextStyles.homeTextStyle,
                    textAlign: TextAlign.center),
                // _texasFlag(),
                const SizedBox(height: 25),
                _arrowButtonRow(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _topTextRow() {

     return Text(
        'You can fit',
        style: AppTextStyles.homeTextStyle,
        textAlign: TextAlign.center,
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
          image: AssetImage(AssetPaths.ROPE_FRAME),
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
        image: AssetImage(AssetPaths.WOOD_FLOORS),
        // Replace 'assets/background_image.jpg' with your image path
        fit: BoxFit.fill, // Adjust the image fit as needed
      ),
    );
  }

  Row _arrowButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _bigRedButton(context),
        _dumbChicken(rotation: 0),
      ],
    );
  }

  Widget _dumbChicken({required double rotation}) {
    return Flexible(
      child: Transform.translate(
        offset: const Offset(0, -15),
        child: SizedBox(
          width: 225,
          height: 225,
          child: Image.asset(
            AssetPaths.DUMB_CHICKEN,
            fit: BoxFit.contain, // Ensures the image scales proportionally
          ),
        ),
      ),
    );
  }

  ImageButton _bigRedButton(BuildContext context) {
    return ImageButton(
      onPressed: () {
        appCubit.navToHowPage();
      },
      image: const AssetImage(AssetPaths.BIG_RED_BUTTON),
      height: 175,
      width: 175,
    );
  }

  Widget _resultsNumber() {
    return AutoSizeText(
      formatWithCommas(searchResult.finalNumberResult),
      style: AppTextStyles.welcomePageTextStyle,
      textAlign: TextAlign.center,
      maxLines: 1,
      // Ensures single-line text
      minFontSize: 12,
      // Set a minimum font size to prevent text from becoming too small
      maxFontSize: 64,
      // Set an initial or maximum font size to start from
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _searchText() {
    return Text(searchResult.search,
        style: AppTextStyles.welcomePageTextStyle, textAlign: TextAlign.center);
  }
}
