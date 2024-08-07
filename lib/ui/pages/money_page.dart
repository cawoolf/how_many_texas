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
            _creditsRow(),
            _buttonRow(context),
            // SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }

  Text _headerText() {
    return Text('Out of credits..',
              style: AppTextStyles.welcomePageTextStyle,
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

  Row _buttonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _bigRedButton(context),
        _bigRedButton(context),
      ],
    );
  }


  ImageButton _bigRedButton(BuildContext context) {
    return ImageButton(
      // Navigation isn't considered UI. How to abstract this away?
      onPressed: () {
        _navToHomePage(context);
      },
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
      Text('Watch an \n Ad',
          style: AppTextStyles.homeTextStyle,
          textAlign: TextAlign.center),
      const SizedBox(width: 15),
      Text('Cash in \n \$0.50',
          style: AppTextStyles.homeTextStyle,
          textAlign: TextAlign.center),
    ],);
  }

  Row _posterImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 10),
        _posterImageBank(),
        _posterImageWanted(),

      ]);
  }

  SizedBox _posterImageBank() {
    return const SizedBox(
      width: 200,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0)), // Adjust the radius as needed
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
      height: 325,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0)), // Adjust the radius as needed
        child: Image(
          image: AssetImage('assets/images/money_page/wanted_poster.png'),
          fit: BoxFit.fill, // Use BoxFit.fill to stretch the image to fit the box
        ),
      ),
    );
  }

  Row _creditsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('4 Credits',
            style: AppTextStyles.homeTextStyle,
            textAlign: TextAlign.center),
        const SizedBox(width: 15),
        Text('50 Credits',
            style: AppTextStyles.homeTextStyle,
            textAlign: TextAlign.center),
      ],);

  }
}
