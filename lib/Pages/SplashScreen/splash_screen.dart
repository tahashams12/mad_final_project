import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raabta/Config/image.dart';
import 'package:raabta/Controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    SplashController splashController = Get.put(SplashController());
    return Scaffold(
      body: Center(
          child: SvgPicture.asset(
        AssetsImage.appIcon,
        height: 90,
        width: 90,
      )),
    );
  }
}
