import 'package:batt_mobile/screens/intro_screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'controllers/credential_controller.dart';
import 'controllers/data_controller.dart';
import 'firebase_options.dart';
import 'utils/constants.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Battmobile App',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          color: backgroundColor
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(CredentialController());
        Get.put(AuthController());
        Get.put(DataController());
      }),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

