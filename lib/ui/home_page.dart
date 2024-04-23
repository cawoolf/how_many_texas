import 'package:flutter/material.dart';

import 'loading_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity, // Makes the child as high as the device screen
        width: double.infinity, // Makes the child as wide as the device screen
        child: _createBodyContent(context),
      ),
    );
  }

  SafeArea _createBodyContent(BuildContext context) {
    return SafeArea( // SafeArea keeps the child widgets from interacting with the OS UI
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildHeaderFooter(),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wood_floors_3.png'), // Replace 'assets/background_image.jpg' with your image path
                fit: BoxFit.fill, // Adjust the image fit as needed
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Widget 1'),
                Text('Widget 2'),
                Text('Widget 3'),
                Text('Widget 4'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoadingPage(),
                      ),
                    );
                  },
                  child: Text('Click Here'),
                )
              ],
            ),
          ),
        ),
         _buildHeaderFooter(),
         ],
    ));
  }

  Container _buildHeaderFooter() {
    return Container(
         height: 120,
          child:
          Row(
              children: [
                Expanded(child:
                Image.asset(
                  'assets/texas_flag_2.png',
                  fit: BoxFit.fill // Adjust the fit as needed
                )),
                Expanded(child:
                Image.asset(
                    'assets/texas_flag_2.png',
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                )],
            ),
          );
  }
}
