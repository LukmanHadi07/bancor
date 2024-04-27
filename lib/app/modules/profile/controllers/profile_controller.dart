import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tambalbanonline/app/modules/auth/controllers/auth_controller.dart';
import 'package:tambalbanonline/app/utils/constants.dart';

class ProfileController extends GetxController {
  static AuthController instance = Get.find();
  late Future<String?> imageUrlFuture;

  @override
  void onInit() {
    super.onInit();
    imageUrlFuture = getImageUrl();
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
