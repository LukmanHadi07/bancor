import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:tambalbanonline/app/modules/auth/controllers/auth_controller.dart';
import 'package:tambalbanonline/app/modules/profile/controllers/profile_controller.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';
import 'package:tambalbanonline/app/utils/constants.dart';
import 'package:tambalbanonline/app/utils/widgets/custom_textfield.dart';

class ProfileView extends StatefulWidget {
    
  const ProfileView({
    Key? key,

  }) : super(key: key);
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthController authController = Get.put(AuthController());

  final ProfileController profileController = Get.put(ProfileController());

  TextEditingController namaController = TextEditingController();

  TextEditingController noHpController = TextEditingController();

  TextEditingController emailController = TextEditingController();

   final FirebaseAuth auth = FirebaseAuth.instance;
  late Future<String?> imageUrlFuture;
  String photoURL = '';
    Timer? refreshTimer;


  @override
  void initState() {
     _getDataUser();
     _refreshImage();
     refreshTimer = Timer.periodic(const Duration(seconds: 2), (_) => _refreshImage());
    super.initState();
  }

  void _getDataUser() async {
    User? user = auth.currentUser;
    namaController.text = user?.displayName ?? "empty";
    noHpController.text = user?.phoneNumber ?? "empty";
    emailController.text = user?.email ?? "empty";
  }


  Future<void> _refreshImage() async {


    await Future.delayed(const Duration(seconds: 3));
    // Dapatkan URL gambar terbaru dari Firebase Storage
    String userId = firebaseAuth.currentUser!.uid;
       if (userId == null) {
        throw Exception('User is not authenticated');
      }
    final storageRef = FirebaseStorage.instance.ref().child('uploads/$userId');
    final downloadURL = await storageRef.getDownloadURL();

    // Perbarui state dengan URL gambar terbaru
    setState(() {
      photoURL = downloadURL;
    });
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
              child: Column(
            children: [
              _profileImage(),
              rowProfile(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Column(
                  children: [
                    CustomTextFieldViews(
                        title: 'Nama', label: 'Nama', controller: namaController),
                    const Gap(10),
                    CustomTextFieldViews(
                        title: 'No Hp',
                        label: 'No Hp',
                        controller: noHpController),
                    const Gap(10),
                    CustomTextFieldViews(
                        title: 'Email',
                        label: 'Email',
                        controller: emailController),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorsApp.orange,
                  ),
                  child: Obx(() {
                    return authController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : TextButton(
                            onPressed: () async {
                              authController.logout();
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ));
                  }),
                ),
              )
            ],
          )),
        ));
  }

  Widget _profileImage() {
   return   GetBuilder<ProfileController>(
        init: profileController ,
        initState: (_) => profileController.getImageUrl(),
        builder:(controller) =>  FutureBuilder<String?>(
        future: controller.imageUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.error),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(photoURL),
            );
          } else {
            return CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person),
            );
          }
        },
      ),);
  }

  Widget rowProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Profile',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed('/profile-update');
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: ColorsApp.ligthBlue),
                ),
              ),
              const Gap(5),
              const Text(
                '>',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: ColorsApp.ligthBlue),
              ),
            ],
          )
        ],
      ),
    );
  }
}
