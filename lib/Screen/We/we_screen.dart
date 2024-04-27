import 'dart:developer';

import 'package:eshanly/Model/service_model.dart';
import 'package:eshanly/Screen/scan_image.dart';
import 'package:flutter/material.dart';

class WeServices extends StatelessWidget {
  WeServices({super.key});
  final List<ServicesModel> services = [
    ServicesModel(serviceName: 'شحن رصيد', serviceCode: '*555*'),
    ServicesModel(serviceName: 'شحن وحدات', serviceCode: '*566*'),
    ServicesModel(serviceName: ' اضعاف شحنتك ', serviceCode: '*501*'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المصريه لاتصالات',
          style: TextStyle(
              color: Color.fromARGB(255, 22, 58, 87), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ScanCardScreen(code: services[index].serviceCode),
              )),
          child: Card(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.black),
              height: 180,
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    services[index].serviceCode,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                    services[index].serviceName,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
