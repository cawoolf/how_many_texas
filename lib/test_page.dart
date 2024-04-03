import 'package:flutter/material.dart';

class MyComponent extends StatelessWidget {
  const MyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity, // Makes the child as high as the device screen
        width: double.infinity, // Makes the child as wide as the device screen
        color: Colors.grey,
        child: _createBodyContent(),
      ),
    );
  }

  SafeArea _createBodyContent() {
    return SafeArea( // SafeArea keeps the child widgets from interacting with the OS UI
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 100,
          color: Colors.blue,
          child: Center(
            child: Text('Widget 1'),
          ),
        ),
        Expanded( // Makes child fill all available space
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text('Widget 2'),
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
