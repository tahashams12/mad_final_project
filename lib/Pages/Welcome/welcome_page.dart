import 'package:flutter/material.dart';
import 'package:raabta/Pages/Welcome/widgets/welcome_body.dart';
import 'package:raabta/Pages/Welcome/widgets/welcome_footer.dart';
import 'package:raabta/Pages/Welcome/widgets/welcome_heading.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WelcomeHeading(),
            WelcomeBody(),
            WelcomeFooter(),
          ],
        ),
      ),
    ));
  }
}
