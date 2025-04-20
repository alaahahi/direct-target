import 'package:direct_target/Controller/AllSettingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:direct_target/Screen/SplashScreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'Controller/CardController.dart';
import 'Controller/CheckInternetController.dart';
import 'Controller/LoaderController.dart';
import 'Controller/ProfileCardController.dart';
import 'Controller/ThemeController.dart';
import 'Controller/TokenController.dart';
import 'Routes/Pages.dart';
import 'Service/ApiService.dart';
import 'Service/CardServices.dart';
import 'Service/SettingsServices.dart';
import 'Translation/AppTranslation.dart';
import 'Service/NotificationService.dart';
import 'package:dio/dio.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Dio dio = Dio();
  MyDioService dioService = MyDioService(dio);

  await dioService.setupDio();
  Get.put(dioService);
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();
  await GetStorage.init();

  await Get.put(InternetController());
  await Get.put(LoaderController());
  await Get.put(ThemeController());
  await Get.put(TokenController());
  await Get.put(ProfileCardController());

  await Get.put(AllSettingController(SettingsServices()));

  runApp(const DirectTarget());
}




class DirectTarget extends StatelessWidget {

  const DirectTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        fallbackLocale: const Locale('ar'),
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
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 14, color: PrimaryColor),
            bodySmall: TextStyle(fontSize: 12, color: Colors.black54),
            headlineLarge: TextStyle(fontSize: 22, color: Colors.black),
            titleMedium: TextStyle(fontSize: 18, color: Colors.black87),
            displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
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
            bodyLarge: TextStyle(fontSize: 16, color: LightGrey),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.grey.shade300),
            bodySmall: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            headlineLarge: TextStyle(fontSize: 24, color: LightGrey),
            titleMedium: TextStyle(fontSize: 18, color: Colors.grey.shade300),
            displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),

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





