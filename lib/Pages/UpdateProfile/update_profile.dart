import 'package:flutter/material.dart';
import 'package:raabta/Widget/primary_button.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              width: 200,
                              height: 200,
                              child:
                                  Center(child: Icon(Icons.person, size: 100)),
                            ),
                            Row(
                              children: [
                                Text('Personal Information',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Name',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'Enter your name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Email',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: 'Enter Email',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Phone Number',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  hintText: 'Enter Phone Number',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PrimaryButton(
                                    btnName: 'Save',
                                    icon: Icons.save,
                                    ontap: () => {}),
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
