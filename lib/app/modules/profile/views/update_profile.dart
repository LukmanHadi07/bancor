import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

import 'package:tambalbanonline/app/modules/auth/controllers/auth_controller.dart';
import 'package:tambalbanonline/app/modules/home/controllers/home_controller.dart';
import 'package:tambalbanonline/app/modules/profile/controllers/update_profile_controller.dart';

import 'package:tambalbanonline/app/routes/app_pages.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';
import 'package:tambalbanonline/app/utils/widgets/custom_textfield.dart';

class UpdateProfile extends StatefulWidget {
  
  const UpdateProfile({
    Key? key,
     }) : super(key: key);
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final AuthController authController = Get.put(AuthController());
  final UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  final HomeController homeController = Get.put(HomeController());

  TextEditingController namaController = TextEditingController();

  TextEditingController noHpController = TextEditingController();

  TextEditingController emailController = TextEditingController();

   final FirebaseAuth auth = FirebaseAuth.instance;

    late Future<String?> imageUrlFuture;

     String _photoURL = '';
     Timer? refreshTimer;
     bool updatingProfile = false;


  @override
  void initState() {
     _getDataUser();
    refreshTimer = Timer.periodic(const Duration(seconds: 2), (_) => _refreshImage());
    super.initState();
  }

    @override
    void dispose() {
      refreshTimer?.cancel(); 
      super.dispose();
    }

 

  void _getDataUser() async {
    User? user = auth.currentUser;
    namaController.text = user?.displayName ?? "empty";
    emailController.text = user?.email ?? "empty";
  }


   
  Future<void> _refreshImage() async {
    try {
        User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      final storageRef =
          FirebaseStorage.instance.ref().child('uploads/$userId');
      final downloadURL = await storageRef.getDownloadURL();
      if (mounted) {
        setState(() {
          _photoURL = downloadURL;
        });
      }
    }
    } catch (e) {
      print(e); 
    }
  
  }



   Future<void> updateProfile(String displayName) async {
   if (mounted) {
     setState(() {
      updatingProfile = true;
    });
   }
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.updateDisplayName(displayName);
      await Future.delayed(const Duration(seconds: 1)); 
      Get.snackbar('Profil diperbarui', 'Profiil Telah Di Perbarui');
        Get.offNamed(Routes.profileScreen);
    } catch (e) {
       Get.snackbar('Profil gagal diperbarui', 'Profiil gagal diperbarui');
    } finally {
      setState(() {
        updatingProfile = false;
      });
    }
  }

 


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           Get.back(); 
          },
        ),
      ),
      body:  SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: Center(
            child: Column(
              children: [
               _profileImage(context),
               rowProfile(),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                 child: Column(
                   children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextField(
                       
                        controller: namaController,
                        enabled: true,
                        decoration: const  InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsApp.orange, width: 2.0),
                          ),
                            hintText: 'Nama',
                            hintStyle: TextStyle(color: Colors.black87),
                            ),
                            
                      ),
                    ),
                     const Gap(10),
                       CustomTextFieldViews(title: 'Email', label: 'Email', controller: emailController),
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
                    color: ColorsApp.ligthBlue,
                   ),
                   child: TextButton(onPressed: (){
                     updateProfile(namaController.text);
                   }, child: updatingProfile ? const CircularProgressIndicator() : const Text('Simpan', style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                   ),)),
                 ),
               )
              ],
            ),
          ),
      )
    );
  }

  Widget _profileImage(BuildContext context) {
    return  Column(
      children: [
       GetBuilder<UpdateProfileController>(
        init: updateProfileController ,
        initState: (_) => updateProfileController.getImageUrl(),
        builder:(controller) =>  FutureBuilder<String?>(
        future: controller.imageUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.error),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return Obx(() {
              if (controller.isLoading.value) {
                return CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: const CircularProgressIndicator(),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: _refreshImage,
                  child:  CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_photoURL,),
                       
                    )
                );
              }
            });
          } else {
            return CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person),
            );
          }
        },
      ),),
        const Gap(10),
        GestureDetector(
          onTap: () async {
            final pickedImage = await updateProfileController.pickImage();
            if (pickedImage != null) {
              final imageUrl = await updateProfileController.uploadImage(pickedImage);
              if (imageUrl != null) {
                  Get.snackbar('Success', 'Image uploaded successfully');
              }
            }
          },
          child: const Text('Upload Gambar', style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),),
        )
      ],
    );
  }

  Widget rowProfile() {
    return  const Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text('Profile', style: TextStyle(
            fontSize: 26, 
            fontWeight: FontWeight.bold
           ),),
        ],
      ),
    );
  }
}