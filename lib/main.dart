import 'package:flutter/material.dart';
import 'package:weather_app_api/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white, 
        colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue).copyWith(secondary: Colors.white),
      ),
      home: const MyHomePage()
    );
  }
}

