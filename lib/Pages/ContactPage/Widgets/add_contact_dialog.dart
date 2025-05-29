import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raabta/Controller/contact_contoller.dart';

class AddContactDialog extends StatelessWidget {
  final ContactContoller controller;

  const AddContactDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Clear previous values when dialog opens
    controller.contactName.value = '';
    controller.contactEmail.value = '';
    controller.contactPhone.value = '';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Contact',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.person),
              ),
              onChanged: (value) => controller.contactName.value = value,
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.email),
                hintText: 'example@email.com',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => controller.contactEmail.value = value,
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.phone),
                hintText: '+1234567890',
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) => controller.contactPhone.value = value,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Cancel'),
                ),
                Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => controller.addContact(),
                        child: Text('Add Contact'),
                      )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
