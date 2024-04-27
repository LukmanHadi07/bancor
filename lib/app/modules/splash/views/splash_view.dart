import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/auth/controllers/auth_controller.dart';
import 'package:tambalbanonline/app/routes/app_pages.dart';



class SplashView extends StatelessWidget {
  const SplashView({super.key});

 

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      final AuthController authController = Get.put(AuthController());
       if (authController.isLoggedIn.value) {
       Get.offNamed(Routes.homeScreen);
    } else {
       Get.offNamed(Routes.loginScreen);
    }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Center(child: Image.asset('assets/LOGO.png',  height: 200,)),
             const SizedBox(
              height: 35,
             ),
             const Text('BANCOR' , style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Color(0xffFF701D)
             ),),
          Center(
           
  child: Container(
    width: double.infinity, // Expand container to fill available width
    padding:const  EdgeInsets.symmetric(horizontal: 16.0), // Add padding for space on both sides
    child: const Column(
      children: [
        Text(
          'Solusi tercepat untuk anda. Ayo bergabung bersama kami',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xff2596BE),
          ),
          textAlign: TextAlign.justify,
        ),
         Text(
          'Pastikan kemudahannya di aplikasi Bancor',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xff2596BE),
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}