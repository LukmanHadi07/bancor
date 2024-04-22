import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/profile/bindings/updateprofile_binding.dart';
import 'package:tambalbanonline/app/modules/profile/views/update_profile.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.SPLASH;

  static const splashscreen = '/';
  static const registerScreen = '/register';
  static const loginScreen = '/login';
  static const homeScreen = '/home';
  static const profileScreen = '/profile';
static const updateProfileScreen = '/profile-update';

  static final routes = [
    GetPage(
      name: splashscreen,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: registerScreen,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: profileScreen,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
      GetPage(
      name: updateProfileScreen,
      page: () => const UpdateProfile(),
      binding: UpdateProfileBinding(),
    ),
  ];
}
