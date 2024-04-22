import 'package:flutter/material.dart';
import 'package:how_many_texas/ui/home_page.dart';

import 'loading_page.dart';


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
            Container(
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text('***Response Page***'),
              ),
            ),
            Expanded( // Makes child fill all available space
              child: Container(
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text('Widget 1'),
                    Text('Widget 2'),
                    Text('Widget 3'),
                    Text('Widget 4'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: Text('Click Here'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              color: Colors.orange,
              child: Center(
                child: Text('Widget 3'),
              ),
            ),
          ],
        ));
  }
}
