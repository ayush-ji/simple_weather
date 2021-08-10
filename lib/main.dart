import 'package:flutter/material.dart';
//import 'package:simple_weather/screens/MainScreen/screen.dart';
//import 'screens/MainScreen/screen.dart';
import 'screens/LoadingScreen.dart';

void main() {
  runApp(Start());
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoadingScreen(),
      ),
    );
  }
}







