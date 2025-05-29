import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raabta/Config/image.dart';
import 'package:raabta/Config/strings.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsImage.boyPic, height: 90, width: 90.0),
            SvgPicture.asset(AssetsImage.connect, height: 40, width: 40.0),
            SvgPicture.asset(AssetsImage.girlPic, height: 80, width: 80.0),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          WelcomePageString.tagLine,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          WelcomePageString.connected,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          WelcomePageString.description,
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
