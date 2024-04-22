import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tambalbanonline/app/utils/constants.dart';

class AuthController extends GetxController {
static AuthController instance = Get.find();
final String isLoggedInKey = 'IsLoggedIn';


final RxBool isLoading = false.obs;
late Rx<User?> firebaseUser;
final RxBool isLoggedIn = false.obs;


@override
  void onInit() {
    super.onInit();
    checkLoggedIn();
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
  }


  Future<void> checkLoggedIn() async {
    isLoggedIn.value = await isLoggedInLocally();
    if (isLoggedIn.value) {
       Get.offNamed('/home');
    }
  }

  Future<bool> isLoggedInLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  // method menyimpan session login dilocal ?
  Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, value);
    isLoggedIn.value = value;
  }
  
  void register(String email, String password )  async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Registration Success');
      Get.offNamed('/login');
    } catch (firebaseAuthException) {}
  }

  void login(String email, String password) async {
    try {
      isLoading.value = true;
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await setLoggedIn(true);
      Get.snackbar('Success', 'Login Success');
      Get.offNamed('/home');

    } on FirebaseAuthException catch(error) {
       isLoading.value = false;
      if (error.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email');
      } else if (error.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user');
      } else {
        Get.snackbar('Error', 'Login failed: ${error.message}');
      } 
  } catch (e) {
     isLoading.value = false;
      Get.snackbar('Error', 'Login failed: $e');
  }
  }
 
  Future<void> logout() async {
    try {
      isLoading.value = true;
      await firebaseAuth.signOut();
      await setLoggedIn(false);
       Get.snackbar('Success', 'Logout Success');
      Get.offAllNamed('/login');  
    } catch (e) {
      print(e); 
      Get.snackbar('Error', 'Logout failed: $e');
    } finally {
       isLoading.value = false;
    }
  }
}