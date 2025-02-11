// import 'dart:developer';
//
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:direct_target/Model/PrivacyPolicyModel.dart';
// import 'package:direct_target/Model/TermsModel.dart';
//
// import '../Service/TermsAndPrivacyService.dart';
// import 'LoaderController.dart';
//
// class TermsAndPrivacyController extends GetxController {
//   final loaderController = Get.put(LoaderController());
//
//   TermsConditions termsConditions = TermsConditions();
//   PrivacyPolicy privacyPolicy = PrivacyPolicy();
//
//   @override
//   void onInit() {
//     // Perform initialization tasks here
//     getPrivacy();
//     getTerms();
//     super.onInit();
//   }
//
//   Future<dynamic> getTerms() async {
//     loaderController.loading(true);
//     try {
//       var res = await TermsAndPrivacyService().getTermsConditions();
//
//       termsConditions = res.termsConditions!.first;
//       print(res.termsConditions!.first.termsConditions);
//     } catch (e) {
//       if (e is DioException) {
//         log(e.toString());
//       } else {
//         print('errorrrrrr is $e');
//       }
//     }
//     update();
//     loaderController.loading(false);
//   }
//
//   Future<dynamic> getPrivacy() async {
//     loaderController.loading(true);
//     try {
//       var res = await TermsAndPrivacyService().getPrivacyPolicy();
//
//       privacyPolicy = res.privacyPolicy!.first;
//       print(res.privacyPolicy!.first.privacyPloicy);
//     } catch (e) {
//       if (e is DioException) {
//         log(e.toString());
//       } else {
//         print('errorrrrrr is $e');
//       }
//     }
//     update();
//     loaderController.loading(false);
//   }
// }
