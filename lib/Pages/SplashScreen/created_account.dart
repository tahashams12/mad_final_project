import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raabta/Config/image.dart';
import 'package:get/get.dart';
import 'package:raabta/Widget/primary_button.dart';

class AccountCreated extends StatelessWidget {
  const AccountCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SvgPicture.asset(
            AssetsImage.appIcon,
            height: 90,
            width: 90,
          )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Account Created Successfully 🔥",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          PrimaryButton(
              btnName: "Login Now",
              icon: Icons.login,
              ontap: () => {Get.toNamed('/authPage')})
        ],
      ),
    );
  }
}
