import 'package:eshanly/Screen/Etisalat/etisalt_screen.dart';
import 'package:eshanly/Screen/Orange/orange_screen.dart';
import 'package:eshanly/Screen/Vodafone/vadafone_screen.dart';
import 'package:eshanly/Screen/We/we_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> images = [
    'Assets/images/etisalat.png',
    'Assets/images/vodafone.png',
    'Assets/images/we.png',
    'Assets/images/orange.png',
  ];

  final List<Widget> pages = [
    EtisalatServices(),
    VodafoneServices(),
    WeServices(),
    OrangeServices()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'اختر الشريحة',
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pages[index],
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.contain,
                      ))),
            ),
          ),
        ));
  }
}
