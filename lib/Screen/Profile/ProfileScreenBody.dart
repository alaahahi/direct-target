import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ProfileList.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../Controller/ProfileUserController.dart';
import '../../Controller/VerificationWhatsappController.dart';
import '../../Routes/Routes.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final VerificationWhatsappController controller = Get.put(VerificationWhatsappController());
  final ProfileUserController profileController = Get.put(ProfileUserController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Stack(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage("Assets/images/person.png"),
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final profile = profileController.profile.value.data;
            return profile != null
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${profile.name ?? 'N/A'}".tr,
                        style:  Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${profile.phoneNumber ?? 'N/A'}".tr,
                        style:  Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.2500,
                          child: Column(children: [
                            Container(
                              child:
                                Icon(
                                  Icons.fitness_center,  // أيقونة تخص اللياقة البدنية (الوزن)
                                  size: 30,  // الحجم

                                )

                            ),
                            Text(
                              "Weight".tr,
                              style:  Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${profile.weight ?? 'N/A'}".tr,
                              style:  Theme.of(context).textTheme.bodyLarge,
                            )
                          ]),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.white,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.2500,
                          child: Column(children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.0400,
                              width: MediaQuery.of(context).size.width * 0.1500,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("Assets/images/6.png"),
                                    filterQuality: FilterQuality.high),
                              ),
                            ),
                            Text(
                              "Height".tr,
                              style:  Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${profile.height ?? 'N/A'}".tr,
                              style:  Theme.of(context).textTheme.bodyLarge,
                            )
                          ]),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.white,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.2500,
                          child: Column(children: [
                            Container(
                              // height: MediaQuery.of(context).size.height * 0.0400,
                              // width: MediaQuery.of(context).size.width * 0.1500,
                              child :Icon(
                                Icons.accessibility, // يمكنك تغيير هذا إلى Icons.female للجنس الأنثوي
                                size: 30, // حجم الأيقونة

                              ),
                            ),
                            Text(
                              "Gender".tr,
                              style:  Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${profile.gender ?? 'N/A'}".tr,
                              style:  Theme.of(context).textTheme.bodyLarge,
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                : Center(child: Text("No profile data found"));
          }),

          // SizedBox(
          //   height: 30,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         height: MediaQuery.of(context).size.height * 0.12,
          //         width: MediaQuery.of(context).size.width * 0.2500,
          //         child: Column(children: [
          //           Container(
          //             height: MediaQuery.of(context).size.height * 0.0400,
          //             width: MediaQuery.of(context).size.width * 0.1500,
          //             decoration: const BoxDecoration(
          //               image: DecorationImage(
          //                   image: AssetImage("Assets/icons/callories.png"),
          //                   filterQuality: FilterQuality.high),
          //             ),
          //           ),
          //           Text(
          //             "Calories".tr,
          //             style:  Theme.of(context).textTheme.bodyLarge,
          //           ),
          //           const SizedBox(
          //             height: 5,
          //           ),
          //           Text(
          //             "103lbs".tr,
          //             style:  Theme.of(context).textTheme.bodyLarge,
          //           )
          //         ]),
          //       ),
          //       Container(
          //         height: 50,
          //         width: 1,
          //         color: Colors.white,
          //       ),
          //       Container(
          //         height: MediaQuery.of(context).size.height * 0.12,
          //         width: MediaQuery.of(context).size.width * 0.2500,
          //         child: Column(children: [
          //           Container(
          //             height: MediaQuery.of(context).size.height * 0.0400,
          //             width: MediaQuery.of(context).size.width * 0.1500,
          //             decoration: const BoxDecoration(
          //               image: DecorationImage(
          //                   image: AssetImage("Assets/icons/weight.png"),
          //                   filterQuality: FilterQuality.high),
          //             ),
          //           ),
          //           Text(
          //             "Weight".tr,
          //             style:  Theme.of(context).textTheme.bodyLarge,
          //           ),
          //           const SizedBox(
          //             height: 5,
          //           ),
          //           Text(
          //             "756cal".tr,
          //             style:  Theme.of(context).textTheme.bodyLarge,
          //           )
          //         ]),
          //       ),
          //       Container(
          //         height: 50,
          //         width: 1,
          //         color: Colors.white,
          //       ),
          //       Container(
          //         height: MediaQuery.of(context).size.height * 0.12,
          //         width: MediaQuery.of(context).size.width * 0.2500,
          //         child: Column(children: [
          //           Container(
          //             height: MediaQuery.of(context).size.height * 0.0400,
          //             width: MediaQuery.of(context).size.width * 0.1500,
          //             decoration: const BoxDecoration(
          //               image: DecorationImage(
          //                   image: AssetImage("Assets/icons/heart.png"),
          //                   filterQuality: FilterQuality.high),
          //             ),
          //           ),
          //           Text(
          //             "Heart rate".tr,
          //             style:  Theme.of(context).textTheme.bodyLarge,
          //           ),
          //           const SizedBox(
          //             height: 5,
          //           ),
          //           Text(
          //             "215bpm",
          //             style:  Theme.of(context).textTheme.bodyLarge,
          //           )
          //         ]),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 650,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? DarkBGColor
                  : LightGrey,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.changeprofile);
                  },
                  child: ProfileList(
                    title: 'Change Profile'.tr,
                    icon:Icons.edit_note_rounded,
                    iconColor: Colors.deepPurpleAccent,
                    textColor: Colors.black,),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.privacy);
                  },
                  child: ProfileList(
                    icon: Icons.chat,
                    title: "Privacy & Policy".tr,
                    iconColor: Colors.green,
                    textColor: Colors.black,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.terms);
                  },
                  child:ProfileList(
                    icon: Icons.payment,
                    title: "Terms & Condition".tr,
                    iconColor: Colors.purple,
                    textColor: Colors.black,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: "Confirm Logout".tr,
                      middleText: "Are you sure you want to log out?".tr,
                      textCancel: "No".tr,
                      textConfirm: "Yes".tr,
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        controller.logout();
                        Get.back();
                      },
                    );
                  },
                  child: ProfileList(
                    icon: Icons.logout,
                    title: "Log out".tr,
                    iconColor: Colors.red,
                    textColor: Colors.red,
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}

