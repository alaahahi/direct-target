// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:direct_target/Routes/Routes.dart';
import 'package:direct_target/Screen/Auth/SignIn/SignInScreen.dart';

import 'package:direct_target/Screen/Profile/ProfileScreen.dart';
import 'package:direct_target/Screen/OnBoard/BoardingScreen.dart';
import 'package:direct_target/Screen/SplashScreen.dart';

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
];
