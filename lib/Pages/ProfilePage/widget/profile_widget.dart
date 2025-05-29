import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raabta/Controller/profile_controller.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/images/img.png', height: 100, width: 100)
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Obx(
                    () => Text(
                      profileController.currentUser.value.name ?? 'User Name',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Obx(
                    () => Text(
                      profileController.currentUser.value.email ?? 'User Email',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )
                ]),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.surface),
                        child: Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Call",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.surface),
                        child: Row(
                          children: [
                            Icon(Icons.video_call, color: Colors.blue),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Video Call",
                                style: TextStyle(color: Colors.blue))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.surface),
                        child: Row(
                          children: [
                            Icon(Icons.message, color: Colors.yellow),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Chat", style: TextStyle(color: Colors.yellow))
                          ],
                        ),
                      )
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
