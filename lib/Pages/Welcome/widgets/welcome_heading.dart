import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raabta/Config/image.dart';
import 'package:raabta/Config/strings.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsImage.appIcon,
              width: 90.0, // Set the width of the logo
              height: 90.0, // Set the height of the logo
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineLarge,
        )
      ],
    );
  }
}
