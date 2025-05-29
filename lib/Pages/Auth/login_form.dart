import 'package:flutter/material.dart';
import 'package:raabta/Controller/auth_controller.dart';
import 'package:raabta/Widget/primary_button.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    AuthController authController = Get.put(AuthController());
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: email,
          decoration: InputDecoration(
            hintText: "Email",
            labelText: "Email",
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: password,
          decoration: InputDecoration(
            hintText: "Password",
            labelText: "Password",
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => authController.isLoading.value
              ? CircularProgressIndicator()
              : PrimaryButton(
                  ontap: () {
                    authController.login(email.text, password.text);
                    //  Get.offAllNamed('/home');
                  },
                  btnName: 'Login',
                  icon: Icons.login,
                ),
        )
      ],
    );
  }
}
