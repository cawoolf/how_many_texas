
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/ui/common_widgets/image_button.dart';
import 'package:how_many_texas/constants/text_styles.dart';

import '../../cubit/app_cubit.dart';
import '../common_widgets/rotated_image.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: double.infinity, // Makes the child as high as the device screen
        width: double.infinity, // Makes the child as wide as the device screen
        child: _createBodyContent(context),
      ),
    );
  }

  SafeArea _createBodyContent(BuildContext context) {
   // Create a TextEditingController
    return SafeArea(
      // SafeArea keeps the child widgets from interacting with the OS UI
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
                    padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0 , 0) ,
                child: _buildHeaderFooter()),
                  const SizedBox(height: 35),
                  Text(
                    'How many of this thing right here..',
                    style: AppTextStyles.homeTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _bigRedArrow(rotation: 90),
                  const SizedBox(
                    height: 30,
                  ),
                  _inputTextBox(controller: _controller),
                  // Pass the controller to _inputTextBox
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Can fit inside of Texas?',
                    style: AppTextStyles.homeTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  _arrowButtonRow(context),
                  // _buildHeaderFooter(),
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
        image: AssetImage('assets/wood_floors_3.png'),
        // Replace 'assets/background_image.jpg' with your image path
        fit: BoxFit.fill, // Adjust the image fit as needed
      ),
    );
  }

  RotatedImage _bigRedArrow({required double rotation}) {
    return RotatedImage(
      rotation: rotation,
      // Replace 'assets/your_image.png' with the actual path to your image asset
      width: 100,
      // Set the desired width
      height: 100,
      image: Image.asset('assets/arrow_down.png'), // Set the desired height
    );
  }

  ImageButton _bigRedButton(BuildContext context) {
    return ImageButton(
      onPressed: () {
        // _navToLoadingPage(context);
        _submitAPIRequests(context);
      },
      image: const AssetImage('assets/big_red_button.png'),
      height: 150,
      width: 200,
    );
  }


  void _submitAPIRequests(BuildContext context) {
    String searchText = _controller.text;
    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.apiRequests(searchText);

  }

  SizedBox _inputTextBox({required TextEditingController controller}) {
    return SizedBox(
      width: 300, // Set the width of the text input box
      child: TextField(
        controller: controller, // Assign the controller to the TextField
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          // Set white background
          hintText: 'Enter text...',
          // Placeholder text
          hintStyle: TextStyle(color: Colors.black),
          // Set black hint text color
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 10.0, // Set border width
            ),
          ), // Add border
        ),
        onTap: () {
          // Clear the hint text when user taps on the text field
          if (controller.text == 'Enter text...') {
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
          Expanded(
            child: Image.asset('assets/texas_flag_wavy_trimmed.png',// Adjust the fit as needed
                ),
          ),
        ],
      ),
    );
  }
}
