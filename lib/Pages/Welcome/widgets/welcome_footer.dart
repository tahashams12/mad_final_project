import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:raabta/Config/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raabta/Config/image.dart';
import 'package:get/get.dart';

class WelcomeFooter extends StatelessWidget {
  const WelcomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideAction(
          onSubmit: () => Get.offAllNamed("/authPage"),
          text: WelcomePageString.slideToStart,
          textStyle: Theme.of(context).textTheme.labelLarge,
          innerColor: Theme.of(context).colorScheme.primary,
          outerColor: Theme.of(context).colorScheme.primaryContainer,
          sliderButtonIcon: Icon(
            Icons.arrow_forward,
            size: 20,
          ),
          submittedIcon: SvgPicture.asset(AssetsImage.plug),
          height: 50.0, // Adjust the height as needed
          sliderButtonYOffset: -10.0, // Adjust the Y offset as needed
        )
      ],
    );
  }
}
