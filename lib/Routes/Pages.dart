import 'package:direct_target/Screen/Notification/NotificationScreen.dart';
import 'package:direct_target/Screen/Profile/App%20Info/AppInfoScreen.dart';
import 'package:direct_target/Screen/Profile/Contact/ContactScreen.dart';
import 'package:direct_target/Screen/Profile/PrivacyPolicy/PricavyPolicyScreen.dart';
import 'package:direct_target/Screen/Profile/Terms/TermsScreen.dart';
import 'package:direct_target/Screen/RequestCard/RequestScreen.dart';
import 'package:get/get.dart';
import 'package:direct_target/Routes/Routes.dart';
import 'package:direct_target/Screen/Auth/SignIn/SignInScreen.dart';
import 'package:direct_target/Screen/OnBoard/BoardingScreen.dart';
import 'package:direct_target/Screen/SplashScreen.dart';
import '../Screen/Auth/Verify/VerificationScreenBody.dart';
import '../Screen/Home/NavigationBar/NavigationBarScreen.dart';
import '../Screen/My Card/Appointment Scheduling/ScheduleScreen.dart';
import '../Screen/Profile/ChangeProfile/ChangeProfileScreen.dart';
import '../Screen/Search/SearchScreen.dart';
import '../Screen/Services/TopDoctorScreen.dart';



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
    page: () =>  NavigationBarScreen(),
  ),
  GetPage(
    name: AppRoutes.changeprofile,
    page: () =>  ChangePasswordScreen(),
  ),

  GetPage(
    name: AppRoutes.appointment,
    page: () =>  SheduleScreen(),
  ),
  GetPage(
    name: AppRoutes.privacy,
    page: () =>  PrivacyPolicyScreen(),
  ),
  GetPage(
    name: AppRoutes.terms,
    page: () =>  TermsScreen(),
  ),
  GetPage(
    name: AppRoutes.appinfo,
    page: () =>  AppInfoScreen(),
  ),
  GetPage(
    name: AppRoutes.contact,
    page: () =>  ContactScreen(),
  ),
  GetPage(
    name: AppRoutes.notification,
    page: () =>  NotificationScreen(),
  ),
  GetPage(
    name: AppRoutes.requestcard,
    page: () =>  RequestScreen(),
  ),
  GetPage(
    name: AppRoutes.search,
    page: () =>  SearchPage(),
  ),
  GetPage(
    name: AppRoutes.topdoctor,
    page: () =>  TopDoctorScreen(),
  ),
];
