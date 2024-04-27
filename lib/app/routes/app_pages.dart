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

   

  static final routes = [
    GetPage(
      name: Routes.splashscreen,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.registerScreen,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
      GetPage(
      name: Routes.updateProfileScreen,
      page: () => const UpdateProfile(),
      binding: UpdateProfileBinding(),
    ),
  ];
}
