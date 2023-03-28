import 'package:flutter/material.dart';
class Test extends StatelessWidget {
  final String text;
  Test({required this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text),),
    );
  }
}