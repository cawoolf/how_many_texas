import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/constants/asset_paths.dart';
import 'package:how_many_texas/ui/common_widgets/image_button.dart';
import 'package:how_many_texas/constants/text_styles.dart';
import '../../cubit/app_cubit.dart';
import '../common_widgets/rotated_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;
  late AppCubit appCubit;

  @override
  void initState() {
    super.initState();
    appCubit = BlocProvider.of<AppCubit>(context);
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: _createBodyContent(context),
      ),
    );
  }

  SafeArea _createBodyContent(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: Container(
              decoration: _woodBackground(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0),
                    child: _buildHeaderFooter(),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    'How many of this thing right here..',
                    style: AppTextStyles.homeTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  _bigRedArrow(rotation: 90),
                  const SizedBox(height: 30),
                  _textBoxStack(controller: _controller),
                  const SizedBox(height: 30),
                  Text(
                    'Can fit inside of Texas?',
                    style: AppTextStyles.homeTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  _arrowButtonRow(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _arrowButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(56, 0, 0, 0),
          child: _bigRedArrow(rotation: 0),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
          child: _bigRedButton(context),
        ),
      ],
    );
  }

  BoxDecoration _woodBackground() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AssetPaths.WOOD_FLOORS),
        fit: BoxFit.fill,
      ),
    );
  }

  RotatedImage _bigRedArrow({required double rotation}) {
    return RotatedImage(
      rotation: rotation,
      width: 100,
      height: 100,
      image: Image.asset(AssetPaths.ARRORW_DOWN),
    );
  }

  ImageButton _bigRedButton(BuildContext context) {
    return ImageButton(
      onPressed: () async {
        bool creditCheck = await appCubit.creditCheck();
        creditCheck ? _submitAPIRequests() : appCubit.navToMoneyPage();
      },
      image: const AssetImage(AssetPaths.BIG_RED_BUTTON),
      height: 150,
      width: 200,
    );
  }

  void _submitAPIRequests() {
    String searchText = _controller.text.trim();
    if (searchText.isNotEmpty) {
      appCubit.apiRequests(searchText);
    }
  }

  SizedBox _inputTextBox({required TextEditingController controller}) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter text...',
          hintStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 10.0,
            ),
          ),
        ),
        onTap: () {
          if (controller.text.isEmpty || controller.text == 'Enter text...') {
            controller.clear();
          }
        },
      ),
    );
  }

  SizedBox _buildHeaderFooter() {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          _texasFlag(),
          _creditStar(),
        ],
      ),
    );
  }

  Expanded _texasFlag() {
    return Expanded(
      child: Image.asset(
        AssetPaths.TEXAS_FLAG,
      ),
    );
  }

  Expanded _creditStar() {
    return Expanded(
      child: Stack(
        children: [
          Center(child: Image.asset(AssetPaths.STAR)),
          Center(
            child: Text(
              appCubit.getCredits().toString(),
              style: AppTextStyles.welcomePageTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Stack _textBoxStack({required TextEditingController controller}) {
    return Stack(
      children: [
        Center(child: _inputTextBox(controller: controller)),
      ],
    );
  }
}
