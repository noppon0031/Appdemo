import 'package:flutter/material.dart';

import 'Business/add_image.dart';
class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddImage())),
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}