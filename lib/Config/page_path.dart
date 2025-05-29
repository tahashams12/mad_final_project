import 'package:get/get.dart';
import 'package:raabta/Pages/Auth/auth_page.dart ';
import 'package:raabta/Pages/Chat/chat_page.dart';
import 'package:raabta/Pages/ContactPage/contact_page.dart';
import 'package:raabta/Pages/Homepage/home_page.dart';
import 'package:raabta/Pages/ProfilePage/profile_page.dart';
import 'package:raabta/Pages/SplashScreen/created_account.dart';
import 'package:raabta/Pages/UpdateProfile/update_profile.dart';
import 'package:raabta/Pages/user profile/user_profile.dart';

var pagePath = [
  GetPage(
      name: "/authPage",
      page: () => AuthPage(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/home",
      page: () => HomePage(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/chat",
      page: () => ChatPage(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/profile",
      page: () => ProfilePage(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/updateProfile",
      page: () => UpdateProfile(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/userProfile",
      page: () => UserProfile(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/accountCreated",
      page: () => AccountCreated(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/contactPage",
      page: () => Contactpage(),
      transition: Transition.rightToLeft),
];
