import 'package:flutter/material.dart';
import 'package:raabta/Controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:raabta/Pages/ProfilePage/widget/profile_widget.dart';
import 'package:raabta/Widget/primary_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Get.toNamed('/updateProfile');
              },
            )
          ],
          title: Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          ProfileWidget(),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                  btnName: "Logout",
                  icon: Icons.logout,
                  ontap: () => {AuthController().signOutUser()})
            ],
          )
        ]),
      ),
    );
  }
}
