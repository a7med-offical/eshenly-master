import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);

    _animationController.forward();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'Assets/images/splash.jpg',
                height: 300,
                width: 300,
                fit: BoxFit.fill,
              ))),
    );
  }
}
