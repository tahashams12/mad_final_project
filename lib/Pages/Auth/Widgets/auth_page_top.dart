import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raabta/Pages/Auth/login_form.dart';
import 'package:raabta/Pages/Auth/signup_form.dart';

class AuthPageTop extends StatelessWidget {
  const AuthPageTop({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;

    return Column(
      children: [
        Obx(
          () => AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(20),
            height: isLogin.value ? 330 : 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                isLogin.value = true;
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Login",
                                    style: isLogin.value
                                        ? Theme.of(context).textTheme.bodyLarge
                                        : Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                  ),
                                  SizedBox(height: 5),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    height: 5,
                                    width: isLogin.value ? 150 : 0,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                isLogin.value = false;
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Sign Up",
                                    style: isLogin.value
                                        ? Theme.of(context).textTheme.labelLarge
                                        : Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  SizedBox(height: 5),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    height: 5,
                                    width: isLogin.value ? 0 : 150,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(() => isLogin.value ? LoginForm() : SignupForm()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
