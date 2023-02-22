import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:touch_n_dine/admin_home.dart';
import 'package:touch_n_dine/home_page.dart';
import 'package:touch_n_dine/login.dart';

import 'branch_admin.dart';

void main() async {
// get storage init

  WidgetsFlutterBinding.ensureInitialized();
  // Init GetStorage
  await GetStorage.init();

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
        GetPage(
          name: "/branch_admin",
          page: () => const BranchAdmin(),
        ),
         GetPage(
          name: "/admin_home",
          page: () => const AdminHomePage(),
        ),
      ],
      // initialRoute: "/",
      initialRoute: "/admin_home",
    );
  }
}
