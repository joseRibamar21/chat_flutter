import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        Future.delayed(const Duration(milliseconds: 1500))
            .then((value) => Get.offAndToNamed('/home'));
        return Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: const Color(0xFF1D356C),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset("lib/ui/assets/imgs/logo.png",
                fit: BoxFit.fitWidth),
          ),
        );
      }),
    );
  }
}
