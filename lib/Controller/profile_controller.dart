import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:raabta/Model/user_model.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  Rx<userModel> currentUser = userModel().obs;
  @override
  void onInit() async {
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    await db.collection('users').doc(auth.currentUser!.uid).get().then(
          (value) => {
            currentUser.value = userModel.fromJson(
              value.data()!,
            ),
          },
        );
  }

  Future<void> updateProfile(
      String? name, String? bio, String? phone, String? email) async {
    isLoading.value = true; // Show loading indicator
    try {
      String userId = auth.currentUser!.uid;

      // Update the user data in Firestore
      await db.collection('users').doc(userId).update({
        'name': name ?? currentUser.value.name,
        'bio': bio ?? currentUser.value.bio,
        'phone': phone ?? currentUser.value.phone,
        'email': email ?? currentUser.value.email,
      });

      // Update the local observable to reflect changes in UI
      currentUser.value = userModel(
        name: name ?? currentUser.value.name,
        bio: bio ?? currentUser.value.bio,
        phone: phone ?? currentUser.value.phone,
        email: email ?? currentUser.value.email,
      );

      // Show a success message
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      // Handle any errors during the update
      Get.snackbar('Error', 'Failed to update profile: $e');
      print("Error updating profile: $e");
    } finally {
      isLoading.value = false; // Hide loading indicator after operation
    }
  }
}
