import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:direct_target/Screen/SplashScreen.dart';
import 'package:direct_target/Screen/OnBoard/FirstBoardScreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'Controller/LoaderController.dart';
import 'Controller/ThemeController.dart';
import 'Controller/TokenController.dart';
import 'Controller/VerificationWhatsappController.dart';
import 'Routes/Pages.dart';
import 'Screen/OnBoard/SecondBoardScreen.dart';
import 'Screen/OnBoard/ThirdBoardScreen.dart';
import 'Screen/RequestCard/RequestScreen.dart';
import 'Screen/RequestCard/RequestScreenBody.dart';
import 'Translation/AppTranslation.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  Get.put(LoaderController()); // تسجيل الـ Controller هنا
  final GetStorage storage = GetStorage();
  String? savedLanguage = storage.read('language');
  Locale initialLocale = const Locale('en', 'US');

  if (savedLanguage == 'ar') {
    initialLocale = const Locale('ar', 'EG');
  }

  Get.put(ThemeController());
  // Get.put(VerificationWhatsappController());
  Get.put(TokenController());
  runApp(DirectTarget(initialLocale: initialLocale));
}

class DirectTarget extends StatelessWidget {
  final Locale initialLocale;

  const DirectTarget({Key? key, required this.initialLocale}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: initialLocale,
        fallbackLocale: const Locale('en', 'US'),
        translationsKeys: AppTranslation.translationKeys,
        theme: ThemeData(
          fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar'
              ? 'Univers Next Arabic Regular'
              : 'coolvetica',
          brightness: Brightness.light,
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 16, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
            bodyMedium: TextStyle(fontSize: 14, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
            bodySmall: TextStyle(fontSize: 12, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
            headlineLarge: TextStyle(fontSize: 24, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
            titleMedium: TextStyle(fontSize: 18, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar'
                ? 'Univers Next Arabic Regular'
                : 'coolvetica'),
            hintStyle: TextStyle(fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar'
                ? 'Univers Next Arabic Regular'
                : 'coolvetica'),
          ),
          primaryColor: PrimaryColor,
          scaffoldBackgroundColor: FormBackGraund,
          appBarTheme: const AppBarTheme(
            backgroundColor: FormBackGraund,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        darkTheme: ThemeData(
          fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar'
              ? 'Univers Next Arabic Regular'
              : 'coolvetica',
          brightness: Brightness.dark,
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 16, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
            bodyMedium: TextStyle(fontSize: 14, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
            bodySmall: TextStyle(fontSize: 12, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
            headlineLarge: TextStyle(fontSize: 24, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
            titleMedium: TextStyle(fontSize: 18, fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar' ? 'Univers Next Arabic Regular' : 'coolvetica'),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar'
                ? 'Univers Next Arabic Regular'
                : 'coolvetica'),
            hintStyle: TextStyle(fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar'
                ? 'Univers Next Arabic Regular'
                : 'coolvetica'),
          ),
          primaryColor: DarkPrimaryColor,
          scaffoldBackgroundColor: DarkBGColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: DarkBGColor,
            iconTheme: IconThemeData(color: DarkTextColor),
            titleTextStyle: TextStyle(fontSize: 22, color: DarkTextColor, fontWeight: FontWeight.w500),
          ),
        ),
        themeMode: themeController.theme,
        getPages: pages,
        title: 'Direct Target',
        home: SplashScreen(),
      );
    });
  }
}





