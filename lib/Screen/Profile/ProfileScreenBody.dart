import 'package:direct_target/Screen/Profile/Contact/ContactScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ProfileList.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../Controller/ProfileUserController.dart';
import '../../Controller/TokenController.dart';
import '../../Controller/VerificationWhatsappController.dart';
import '../../Routes/Routes.dart';
import 'Language/ChangeLanguageScreen.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final VerificationWhatsappController controller = Get.put(VerificationWhatsappController());
  final ProfileUserController profileController = Get.put(ProfileUserController());
  final TokenController tokenController = Get.put(TokenController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // أيقونة فيسبوك
                CircleAvatar(
                  radius: 20, // أصغر من الأيقونات السابقة
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.facebook, color: Colors.white),
                    onPressed: () {
                      // إضافة الرابط أو الحدث
                    },
                  ),
                ),
                SizedBox(width: 15),
                // أيقونة تويتر
                CircleAvatar(
                  radius: 20, // أصغر من الأيقونات السابقة
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: Icon(Icons.telegram, color: Colors.white),
                    onPressed: () {
                      // إضافة الرابط أو الحدث
                    },
                  ),
                ),
                SizedBox(width: 15),
                // أيقونة يوتيوب
                CircleAvatar(
                  radius: 20, // أصغر من الأيقونات السابقة
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: Icon(Icons.play_arrow, color: Colors.white),
                    onPressed: () {
                      // إضافة الرابط أو الحدث
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),

          Obx(() {
            if (tokenController.token.value.isNotEmpty){
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${profile.name ?? 'N/A'}".tr,
                            style:  TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${profile.phoneNumber ?? 'N/A'}".tr,
                            style:  TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)
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
                                    Icons.fitness_center,
                                    size: 30,
                                  )
                              ),
                              Text(
                                "Weight".tr,
                                  style:  TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${profile.weight ?? 'N/A'}".tr,
                                  style:  TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)
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
                                  style:  TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${profile.height ?? 'N/A'}".tr,
                                  style:  TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)
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
                                child :Icon(
                                  Icons.accessibility,
                                  size: 30,

                                ),
                              ),
                              Text(
                                "Gender".tr,
                                  style:  TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${profile.gender ?? 'N/A'}".tr,
                                  style:  TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  : Center(child: Text("No profile data found".tr));
            }
            return SizedBox.shrink();

          }),
         SizedBox(height: 100,),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? DarkBGColor
                  : LightGrey,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 50),
                  Obx(() {
                    if (tokenController.token.value.isNotEmpty) {
                      return Column(
                        children: [
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: Divider(),
                          ),
                        ],
                      );

                    }
                    return SizedBox.shrink();
                  }),

                  InkWell(
                    onTap: () {
                      Get.to(ChangeLanguageScreen());
                    },
                    child: ProfileList(
                      icon: Icons.language,
                      title: "Language".tr,
                      iconColor: Colors.blueGrey,
                      textColor: Colors.black,
                    ),
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
                      icon: Icons.privacy_tip,
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
                      icon: Icons.question_mark_outlined,
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
                      Get.to(ContactScreen());
                    },
                    child: ProfileList(
                      icon: Icons.call,
                      title: "Contact Us".tr,
                      iconColor: Colors.teal,
                      textColor: Colors.black,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.appinfo);
                    },
                    child:ProfileList(
                      icon: Icons.info,
                      title: "App Information".tr,
                      iconColor: Colors.greenAccent,
                      textColor: Colors.black,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  Obx(() {
                    if (tokenController.token.value.isNotEmpty) {
                      return InkWell(
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
                      );
                    }
                    return SizedBox.shrink();
                  }),
                  SizedBox(height: 50),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}

