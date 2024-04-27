import 'dart:developer';

import 'package:eshanly/Model/service_model.dart';
import 'package:eshanly/Model/service_model.dart';
import 'package:eshanly/Screen/scan_image.dart';
import 'package:flutter/material.dart';

class EtisalatServices extends StatelessWidget {
  EtisalatServices({super.key});
  final List<ServicesModel> services = [
    ServicesModel(serviceName: 'شحن رصيد', serviceCode: '*556*'),
    ServicesModel(serviceName: 'شحن ميكسات', serviceCode: '*556*1*'),
    ServicesModel(serviceName: 'شحن دقايق', serviceCode: '*556*2*'),
     ServicesModel(serviceName: 'شحن ميجات', serviceCode: '*556*3*'),

     
   
             

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اتصالات',
          style: TextStyle(
              color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
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


