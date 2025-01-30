import 'package:get/get.dart';
import 'package:direct_target/Routes/Routes.dart';
import 'package:direct_target/Screen/Auth/SignIn/SignInScreen.dart';
import 'package:direct_target/Screen/OnBoard/BoardingScreen.dart';
import 'package:direct_target/Screen/SplashScreen.dart';

import '../Screen/Auth/Verify/VerificationScreenBody.dart';
import '../Screen/Home/HomeScreen.dart';
import '../Screen/Profile/ChangeProfile/ChangeProfileScreen.dart';

final pages = <GetPage>[
  GetPage(
    name: AppRoutes.signinscreen,
    page: () => const SignInScreen(),
  ),
  GetPage(
    name: AppRoutes.onboarding,
    page: () => on_boarding(),
  ),


  GetPage(
    name: AppRoutes.splash,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: AppRoutes.verify,
    page: () =>  VerifyCodeScreen(),
  ),
  GetPage(
    name: AppRoutes.homescreen,
    page: () =>  Homepage(),
  ),
  GetPage(
    name: AppRoutes.changeprofile,
    page: () =>  ChangePasswordScreen(),
  ),
  // GetPage(
  //   name: AppRoutes.viewprofile,
  //   page: () =>  ProfileView(),
  // ),
];
