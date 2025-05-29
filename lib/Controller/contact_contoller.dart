import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raabta/Model/user_model.dart';

class ContactContoller extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxList<userModel> userList = <userModel>[].obs;
  RxBool isLoading = false.obs;

  // New contact fields
  RxString contactName = ''.obs;
  RxString contactEmail = ''.obs;
  RxString contactPhone = ''.obs;

  void onInit() {
    super.onInit();
    getUserList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      userList.clear();

      // Get the current user's contacts
      var contactsSnapshot = await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('contacts')
          .get();

      // If no contacts, return empty list
      if (contactsSnapshot.docs.isEmpty) {
        isLoading.value = false;
        return;
      }

      // Get the user IDs from contacts
      List<String> contactUserIds = contactsSnapshot.docs
          .map((doc) => doc.data()['userId'] as String)
          .toList();

      // Fetch user details for each contact
      for (var userId in contactUserIds) {
        var userDoc = await db.collection('users').doc(userId).get();
        if (userDoc.exists && userDoc.data() != null) {
          userList.add(userModel.fromJson(userDoc.data()!));
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get user list: $e');
      print("Error getting user list: $e");
    }
    isLoading.value = false;
  }

  // New method to add a contact
  Future<void> addContact() async {
    // Validate inputs
    if (contactName.isEmpty || contactEmail.isEmpty || contactPhone.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    // Validate email format
    if (!GetUtils.isEmail(contactEmail.value)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return;
    }

    isLoading.value = true;
    try {
      // Check if user with this email already exists
      var userQuery = await db
          .collection('users')
          .where('email', isEqualTo: contactEmail.value)
          .get();
      String userId;

      if (userQuery.docs.isEmpty) {
        // Show confirmation dialog
        bool createNewUser = await Get.dialog<bool>(
              AlertDialog(
                title: Text('User Not Found'),
                content: Text(
                    'No user with email ${contactEmail.value} exists. Would you like to create this contact?'),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Get.back(result: true),
                    child: Text('Create'),
                  ),
                ],
              ),
            ) ??
            false;

        if (!createNewUser) {
          isLoading.value = false;
          return;
        }

        // Create new user if doesn't exist
        var newUserDoc = db.collection('users').doc();
        userId = newUserDoc.id;

        var newUser = userModel(
            id: userId,
            name: contactName.value,
            email: contactEmail.value,
            phone: contactPhone.value,
            createdAt: DateTime.now().toString(),
            status: 'active');

        await newUserDoc.set(newUser.toJson());
      } else {
        // User already exists
        userId = userQuery.docs.first.id;

        // Don't add your own account as a contact
        if (userId == auth.currentUser!.uid) {
          isLoading.value = false;
          Get.snackbar('Error', 'You cannot add yourself as a contact');
          return;
        }

        // Check if contact is already in user's contacts
        var existingContact = await db
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('contacts')
            .doc(userId)
            .get();

        if (existingContact.exists) {
          isLoading.value = false;
          Get.snackbar('Info', 'This contact is already in your contacts list');
          Get.back(); // Close dialog
          return;
        }
      }

      // Add to current user's contacts collection
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('contacts')
          .doc(userId)
          .set({'added': DateTime.now().toString(), 'userId': userId});

      // Clear form fields
      contactName.value = '';
      contactEmail.value = '';
      contactPhone.value = '';

      // Refresh contact list
      await getUserList();

      Get.back(); // Close the dialog
      Get.snackbar('Success', 'Contact added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add contact: $e');
      print("Error adding contact: $e");
    }
    isLoading.value = false;
  }
}
