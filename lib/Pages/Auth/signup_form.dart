import 'package:flutter/material.dart';
import 'package:raabta/Widget/primary_button.dart';
import 'package:get/get.dart';
import 'package:raabta/Controller/auth_controller.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    AuthController authController = Get.put(AuthController());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: name,
          decoration: InputDecoration(
            hintText: "Full Name",
            labelText: "Name",
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 10,
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
          height: 10,
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: phone,
          decoration: InputDecoration(
            hintText: "Phone number",
            labelText: "Phone",
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 10,
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
          height: 10,
        ),
        Obx(
          () => authController.isLoading.value
              ? CircularProgressIndicator()
              : PrimaryButton(
                  ontap: () {
                    authController.createUser(
                        email.text, password.text, name.text, phone.text);
                  },
                  btnName: 'Signup',
                  icon: Icons.login,
                ),
        )
      ],
    );
  }
}
