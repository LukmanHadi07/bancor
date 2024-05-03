
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/splash/bindings/splash_binding.dart';
import 'package:tambalbanonline/app/routes/app_pages.dart';


const kWebRecaptchaSiteKey = '6Lexz8gpAAAAALH1jYhMZxqWqchRZThDKB-EWHzb';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       getPages: AppPages.routes,
       initialRoute: Routes.splashscreen,
      initialBinding:  SplashBinding()
    );
  }
}

