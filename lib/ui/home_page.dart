import 'package:flutter/material.dart';
import 'package:how_many_texas/ui/common_widgets/image_button.dart';
import 'package:how_many_texas/utils/text_styles.dart';
import 'common_widgets/rotated_image.dart';
import 'loading_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    return SafeArea(
        // SafeArea keeps the child widgets from interacting with the OS UI
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildHeaderFooter(),
        Flexible(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wood_floors_3.png'),
                // Replace 'assets/background_image.jpg' with your image path
                fit: BoxFit.fill, // Adjust the image fit as needed
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'How many of this thing right here..',
                  style: AppTextStyles.yeehawText,
                  textAlign: TextAlign.center,
                ),
                const RotatedImage(
                  imagePath: 'assets/arrow_down.png',
                  // Replace 'assets/your_image.png' with the actual path to your image asset
                  width: 100,
                  // Set the desired width
                  height: 150, // Set the desired height
                ),
                _inputTextBox(),
                SizedBox(height: 20,),
                Text(
                  'Can fit inside of Texas?',
                  style: AppTextStyles.yeehawText,
                  textAlign: TextAlign.center,
                ),

                _bigRedButton(context)
              ],
            ),
          ),
        ),
        _buildHeaderFooter(),
      ],
    ));
  }

  Positioned _bigRedButton(BuildContext context) {
    return Positioned(
      bottom: 30, // Adjust bottom value as needed
      left: 0, // Align to the left edge
      right: 0, // Align to the right edge
      child: ImageButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoadingPage(),
            ),
          );
        },
        key: const Key("home_button"),
        image: AssetImage('assets/big_red_button.png'),
      ),
    );
  }


  SizedBox _inputTextBox() {
    return const SizedBox(
        width: 200, // Set the width of the text input box
        child: TextField(
            decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          // Set white background
          hintText: 'Enter text...',
          // Placeholder text
          hintStyle: TextStyle(color: Colors.black),
          // Set black hint text color
          border: OutlineInputBorder(), // Add border
        )));
  }

  SizedBox _buildHeaderFooter() {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
              child: Image.asset('assets/texas_flag_2.png',
                  fit: BoxFit.fill // Adjust the fit as needed
                  )),
          Expanded(
            child: Image.asset(
              'assets/texas_flag_2.png',
              fit: BoxFit.fill, // Adjust the fit as needed
            ),
          )
        ],
      ),
    );
  }
}
