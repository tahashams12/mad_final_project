import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:raabta/Model/user_model.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user');
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> createUser(
      String email, String password, String name, String phone) async {
    isLoading.value = true;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await initUser(email, name, phone);
      Get.offAllNamed('/accountCreated');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email');
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> signOutUser() async {
    await auth.signOut();
    Get.offAllNamed('/authPage');
  }

  Future<void> initUser(String email, String name, String phone) async {
    var newUser = userModel(
      email: email,
      name: name,
      phone: phone,
      id: auth.currentUser!.uid,
    );

    try {
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(newUser.toJson());
    } catch (ex) {
      print(ex);
    }
  }
}
