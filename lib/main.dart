
import 'package:tindahan/main_wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tindahan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:  Color.fromRGBO(0, 162, 79, 255),
      ),
      home: MainWrapper(),
    );
  }
}
