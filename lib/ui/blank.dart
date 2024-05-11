import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Blank extends StatefulWidget {
  const Blank({super.key});

  @override
  State<StatefulWidget> createState() {
  return _Blank();
  }

}

class _Blank extends State<Blank> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
      ),
    );
  }
}