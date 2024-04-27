import 'package:flutter/material.dart';
import 'package:how_many_texas/ui/home_page.dart';

import 'common_widgets/image_button.dart';



class ResponsePage extends StatelessWidget {
  const ResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity, // Makes the child as high as the device screen
        width: double.infinity, // Makes the child as wide as the device screen
        color: Colors.grey,
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
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/wood_floors_3.png'), // Replace 'assets/background_image.jpg' with your image path
                    fit: BoxFit.cover, // Adjust the image fit as needed
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Widget 1'),
                    const Text('Widget 3'),
                    const Text('Widget 4'),
                    ImageButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      key: const Key("response_button"),
                      image: AssetImage('assets/big_red_button.png'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
