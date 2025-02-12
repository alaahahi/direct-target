import 'package:flutter/material.dart';
import 'package:direct_target/Screen/SplashScreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'Controller/LoaderController.dart';
import 'Controller/ThemeController.dart';
import 'Controller/TokenController.dart';
import 'Routes/Pages.dart';
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
          fontFamily: Get.locale?.languageCode == 'ar'
              ? 'Univers Next Arabic Regular'
              : 'coolvetica',
          primaryColor: PrimaryColor,
          scaffoldBackgroundColor: FormBackGraund,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar'
                ? 'Univers Next Arabic Regular'
                : 'coolvetica'),
            hintStyle: TextStyle(fontFamily: (Get.locale?.languageCode ?? 'en') == 'ar'
                ? 'Univers Next Arabic Regular'
                : 'coolvetica'),
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black),  // لون للنص الفاتح
            bodyMedium: TextStyle(fontSize: 14, color: PrimaryColor),
            bodySmall: TextStyle(fontSize: 12, color: Colors.black54),
            headlineLarge: TextStyle(fontSize: 22, color: Colors.black),
            titleMedium: TextStyle(fontSize: 18, color: Colors.black87),
          ),


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
            bodyLarge: TextStyle(fontSize: 16, color: LightGrey),  // لون للنص الداكن
            bodyMedium: TextStyle(fontSize: 14, color: Colors.grey.shade300),
            bodySmall: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            headlineLarge: TextStyle(fontSize: 24, color: LightGrey),
            titleMedium: TextStyle(fontSize: 18, color: Colors.grey.shade300),
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
            iconTheme: IconThemeData(color: LightGrey),
            titleTextStyle: TextStyle(fontSize: 22, color:  LightGrey, fontWeight: FontWeight.w500),
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





