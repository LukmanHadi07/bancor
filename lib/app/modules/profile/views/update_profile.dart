import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:tambalbanonline/app/modules/auth/controllers/auth_controller.dart';
import 'package:tambalbanonline/app/modules/profile/controllers/update_profile_controller.dart';
import 'package:tambalbanonline/app/modules/profile/views/profile_view.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';
import 'package:tambalbanonline/app/utils/constants.dart';
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

  TextEditingController namaController = TextEditingController();

  TextEditingController noHpController = TextEditingController();

  TextEditingController emailController = TextEditingController();

   final FirebaseAuth auth = FirebaseAuth.instance;

    late Future<String?> imageUrlFuture;

     String _photoURL = '';
     Timer? refreshTimer;
     bool _updatingProfile = false;


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
      _photoURL = downloadURL;
    });
  }



   Future<void> updateProfile(String displayName) async {
    setState(() {
      _updatingProfile = true;
    });
    try {
      // Mendapatkan user saat ini
      User? user = FirebaseAuth.instance.currentUser;

      // Memperbarui displayName
      await user!.updateDisplayName(displayName);


      // Pesan sukses
      print("Profil berhasil diperbarui");

      await Future.delayed(Duration(seconds: 3));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profil berhasil diperbarui'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileView()),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui profil'),
        ),
      );
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
      body:  Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorsApp.orange, width: 2.0),
                        ),
                          hintText: 'Nama',
                          hintStyle: TextStyle(color: Colors.black87),
                          ),
                          
                    ),
                  ),
                   const Gap(10),
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextField(
                      controller: noHpController,
                      enabled: true,
                      decoration: const  InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorsApp.orange, width: 2.0),
                        ),
                          hintText: 'No Hp',
                          hintStyle: TextStyle(color: Colors.black87),
                          ),
                          
                    ),
                  ),
                     const  Gap(10),
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
                 }, child: const Text('Simpan', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                 ),)),
               ),
             )
            ],
          ),
        )
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
              child: CircularProgressIndicator(),
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
              child: Icon(Icons.person),
            );
          }
        },
      ),),
     
    //  FutureBuilder<String?>(
    //   future: updateProfileController.imageUrlFuture,
    //   builder: (context, snapshot) {
    //     return Obx(() {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundColor: Colors.grey[200],
    //           child: CircularProgressIndicator(),
    //         );
    //       } else if (snapshot.hasError) {
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundColor: Colors.grey[200],
    //           child: Icon(Icons.error),
    //         );
    //       } else if (snapshot.hasData && snapshot.data != null) {
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundImage: NetworkImage(snapshot.data!),
    //         );
    //       } else {
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundColor: Colors.grey[200],
    //           child: Icon(Icons.person),
    //         );
    //       }
    //     });
    //   },
    // ),
    // GetX<UpdateProfileController>(
    //   init: updateProfileController,
    //   builder: (controller) => FutureBuilder<String?>(
    //     future: controller.imageUrlFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundColor: Colors.grey[200],
    //           child: CircularProgressIndicator(),
    //         );
    //       } else if (snapshot.hasError) {
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundColor: Colors.grey[200],
    //           child: Icon(Icons.error),
    //         );
    //       } else if (snapshot.hasData && snapshot.data != null) {
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundImage: NetworkImage(snapshot.data!),
    //         );
    //       } else {
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundColor: Colors.grey[200],
    //           child: Icon(Icons.person),
    //         );
    //       }
    //     },
    //   ),
    // ),
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