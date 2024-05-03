
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/auth/controllers/auth_controller.dart';
import 'package:tambalbanonline/app/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
static AuthController instance = Get.find();
final String isLoggedInKey = 'IsLoggedIn';
late Future<String?> imageUrlFuture;



TextEditingController namaController = TextEditingController();
TextEditingController noHpController = TextEditingController();

final RxBool isLoading = false.obs;
late Rx<User?> firebaseUser;
final RxBool isLoggedIn = false.obs;
RxString imageUrl = ''.obs;





@override
  void onInit() {
    super.onInit();
    imageUrlFuture = getImageUrl();
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
  }

  Future<String?>  uploadImage(File imageFile) async {
    try {
       String userId = firebaseAuth.currentUser!.uid;
       if (userId.isEmpty) {
        throw Exception('User is not authenticated');
      }
       firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child('uploads/$userId');
       firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
       await uploadTask.whenComplete(() => null);
       String imageUrl = await ref.getDownloadURL();
       imageUrlFuture = Future.value(imageUrl);
      return imageUrl;
    } catch (e) {
      Get.snackbar('Error', 'Image upload failed: $e');
      return null;
    }
  }

 Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  try {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); 
    if (image == null) {
      return null;
    }
    return File(image.path);
  } catch (e) {
    print(e);
    Get.snackbar('Error', 'Image picking failed: $e');
    return null;
  }
}

 Future<String?> getImageUrl() async {
    try {
      String userId = firebaseAuth.currentUser!.uid;
       if (userId.isEmpty) {
        throw Exception('User is not authenticated');
      }
      final ref = firebase_storage.FirebaseStorage.instance.ref().child('uploads/$userId');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error getting download URL: $e');
      return null;
    }
  }


 

}
