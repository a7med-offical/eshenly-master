import 'package:eshanly/Screen/home_screen.dart';
import 'package:eshanly/Screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EshahnlyApp());
}
class EshahnlyApp extends StatelessWidget {
  const EshahnlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
      routes: {
        '/home' :(context) =>  HomeScreen(),
      },
    );
  }
}

