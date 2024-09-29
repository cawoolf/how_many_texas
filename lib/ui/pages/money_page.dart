import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/constants/asset_paths.dart';
import 'package:how_many_texas/constants/text_styles.dart';
import 'package:how_many_texas/cubit/purchase_service.dart';
import '../../cubit/app_cubit.dart';
import '../common_widgets/image_button.dart';

class MoneyPage extends StatefulWidget {

  const MoneyPage({super.key});

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  late AppCubit appCubit;

  @override
  void initState() {
    appCubit = BlocProvider.of<AppCubit>(context);
    super.initState();
  }

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
        image: AssetImage(AssetPaths.WOOD_FLOORS),
        // Replace 'assets/background_image.jpg' with your image path
        fit: BoxFit.fill, // Adjust the image fit as needed
      ),
    );
  }

  Row _buttonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _playAdButton(context),
        _buyCreditsButton(context),
      ],
    );
  }

  ImageButton _playAdButton(BuildContext context) {

    return ImageButton(
      // Navigation isn't considered UI. How to abstract this away?
      onPressed: () {
        // _playAd();
        // _navToHomePage(context);
        appCubit.loadInterstitialAd();
      },
      image: const AssetImage(AssetPaths.BIG_RED_BUTTON),
      height: 125,
      width: 175,
    );
  }

  ImageButton _buyCreditsButton(BuildContext context) {

    return ImageButton(
      // Navigation isn't considered UI. How to abstract this away?
      onPressed: () async {
        PurchaseService purchaseService = PurchaseService(appCubit: appCubit);
        purchaseService.initPurchase();
      },
      image: const AssetImage(AssetPaths.BIG_RED_BUTTON),
      height: 125,
      width: 175,
    );
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
        _posterImageWanted(),
        _posterImageBank(),

      ]);
  }

  SizedBox _posterImageBank() {
    return const SizedBox(
      width: 200,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0)), // Adjust the radius as needed
        child: Image(
          image: AssetImage(AssetPaths.BANK_POSTER),
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
          image: AssetImage(AssetPaths.WANTED_POSTER),
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

  void _playAd() async{

   await appCubit.setCredits(4);


  }

  void _buyCredits() async {
    await appCubit.setCredits(50);

  }
}
