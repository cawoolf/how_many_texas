import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/constants/text_styles.dart';
import '../../cubit/app_cubit.dart';
import '../common_widgets/image_button.dart';

class MoneyPage extends StatelessWidget {
  final int credits;

  const MoneyPage({super.key, required this.credits});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _headerText(),
            _posterText(),
            _posterImages(),
            _arrowButtonRow(context)
          ],
        ),
      ),
    );
  }

  Text _headerText() {
    return Text('Out of credits..',
              style: AppTextStyles.homeTextStyle,
              textAlign: TextAlign.center);
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

    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.navToHomePage();

  }

  Row _posterText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      Text('Watch an Ad!',
          style: AppTextStyles.homeTextStyle,
          textAlign: TextAlign.center),
      const SizedBox(width: 15),
      Text('Cash in!',
          style: AppTextStyles.homeTextStyle,
          textAlign: TextAlign.center),
    ],);
  }

  Row _posterImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _posterImageBank(),
        _posterImageWanted(),

      ]);
  }

  SizedBox _posterImageBank() {
    return const SizedBox(
      width: 200,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)), // Adjust the radius as needed
        child: Image(
          image: AssetImage('assets/images/money_page/bank.png'),
          fit: BoxFit.fill, // Use BoxFit.fill to stretch the image to fit the box
        ),
      ),
    );
  }

  SizedBox _posterImageWanted() {
    return const SizedBox(
      width: 200,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)), // Adjust the radius as needed
        child: Image(
          image: AssetImage('assets/images/money_page/wanted_poster.png'),
          fit: BoxFit.fill, // Use BoxFit.fill to stretch the image to fit the box
        ),
      ),
    );
  }
}
