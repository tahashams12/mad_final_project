import 'package:flutter/material.dart';
import 'package:raabta/Pages/Auth/Widgets/auth_page_top.dart';
import 'package:raabta/Pages/Welcome/widgets/welcome_heading.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WelcomeHeading(),
                SizedBox(
                  height: 20,
                ),
                AuthPageTop(),
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}
