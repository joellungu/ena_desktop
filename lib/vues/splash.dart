import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'principal.dart';

class Splash extends StatelessWidget {
  Splash() {
    Timer(const Duration(seconds: 3), () {
      Get.to(Principal());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Image.asset(
              "assets/Coat_of_arms_of_the_Democratic_Republic_of_the_Congo.svg.png"),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
