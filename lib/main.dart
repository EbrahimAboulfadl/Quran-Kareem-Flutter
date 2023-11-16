import 'package:flutter/material.dart';
import 'Pages/home.dart';

void main() {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
    throw UnimplementedError();
  }
}
