import 'package:flutter/material.dart';

class MyComponent extends StatelessWidget {
  const MyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey,
        child: _createBodyContent(),
      ),
    );
  }

  Column _createBodyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Text('Widget 1'),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text('Widget 2'),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.orange,
            child: Center(
              child: Text('Widget 3'),
            ),
          ),
        ),
      ],
    );
  }
}
