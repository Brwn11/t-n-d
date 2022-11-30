import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:touch_n_dine/home_page.dart';
import 'package:touch_n_dine/login.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/home",
          page: () => const HomePage(),
        ),
         GetPage(
          name: "/",
          page: () => const LoginPage(),
        ),
      ],
      initialRoute: "/",
    );
  }
}
