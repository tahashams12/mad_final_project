import 'package:flutter/material.dart';
import 'package:raabta/Config/page_path.dart';
//import 'package:raabta/Pages/Auth/auth_page.dart';
import 'package:raabta/Pages/SplashScreen/splash_screen.dart';
import 'Config/themes.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Raabta',
        getPages: pagePath,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        home: const SplashScreen());
  }
}
