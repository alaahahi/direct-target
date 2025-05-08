import 'package:direct_target/Screen/Auth/SignIn/SignInScreen.dart';
import 'package:direct_target/Screen/Profile/Contact/ContactScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ProfileList.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Controller/ProfileCardController.dart';
import '../../Controller/ProfileUserController.dart';
import '../../Controller/TokenController.dart';
import '../../Controller/VerificationWhatsappController.dart';
import '../../Controller/WheelItemController.dart';
import '../../Routes/Routes.dart';
import '../Home/WheelScreen.dart';
import 'Language/ChangeLanguageScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final VerificationWhatsappController controller =
  Get.put(VerificationWhatsappController());
  final ProfileCardController profileController =
  Get.put(ProfileCardController());
  final rewardController = Get.put(WheelItemController());
  final TokenController tokenController = Get.put(TokenController());
  final box = GetStorage();
  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("❌ Couldn't launch $url");
    }
  }
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
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue[900],
            child: IconButton(
              icon: Icon(Icons.facebook, color: Colors.white,size:30),
              onPressed: () => _launchUrl('https://www.facebook.com/share/kD9pYgyu3KaE2rU5/?mibextid=LQQJ4d'),
            ),
          ),
          SizedBox(width: 15),

          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blueAccent,
            child: IconButton(
              icon: Icon(Icons.telegram, color: Colors.white,size:30),
              onPressed: () => _launchUrl('https://t.me/+9647728888483'),
            ),
          ),
          SizedBox(width: 15),

          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.green,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.white,size:30),
              onPressed: () => _launchUrl('https://www.whatsapp.com/channel/0029VaoOky1JJhzdXg9pxS1w'),
            ),
          ),
          SizedBox(width: 15),

          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.pinkAccent,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.instagram, color: Colors.white,size:30),
              onPressed: () => _launchUrl('https://www.instagram.com'),
            ),
          ),

          SizedBox(width: 15),

          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.red,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.youtube, color: Colors.white,size:30),
              onPressed: () => _launchUrl(
                  'https://www.youtube.com/channel/UCsCR_9QtYzGIl8a8mX_G93A?si=lOJ6itEyttNmETyk&cbrd=1'),
            ),
          ),
        ],
      ),
    ),
          SizedBox(height: 15),
          Obx(() {
            if (tokenController.token.value.isNotEmpty) {
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
                                border: Border.all(
                                    width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color:
                                      Colors.black.withOpacity(0.1))
                                ],
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "Assets/images/person.png"),
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
                        Text("${profile.name ?? 'N/A'}".tr,
                            style: TextStyle(color: LightGrey))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            "${profile.phoneNumber ?? 'N/A'}".tr,
                            style: TextStyle(color: LightGrey),
                          ),
                        ),
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
                            height:
                            MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width *
                                0.2500,
                            child: Column(children: [
                              Container(
                                  child: Icon(
                                    Icons.fitness_center,
                                    size: 30,
                                    color: LightGrey,
                                  )),
                              Text("Weight".tr,
                                  style: TextStyle(color: LightGrey)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${profile.weight ?? 'N/A'}".tr,
                                  style: TextStyle(color: LightGrey))
                            ]),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.white,
                          ),
                          Container(
                            height:
                            MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width *
                                0.2500,
                            child: Column(children: [
                              Container(
                                height:
                                MediaQuery.of(context).size.height *
                                    0.0400,
                                width: MediaQuery.of(context).size.width *
                                    0.1500,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "Assets/images/6.png"),
                                      filterQuality: FilterQuality.high),
                                ),
                              ),
                              Text("Height".tr,
                                  style: TextStyle(color: LightGrey)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${profile.height ?? 'N/A'}".tr,
                                  style: TextStyle(color: LightGrey))
                            ]),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.white,
                          ),
                          Container(
                            height:
                            MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width *
                                0.2500,
                            child: Column(children: [
                              Container(
                                child: Icon(
                                  Icons.accessibility,
                                  size: 30,
                                  color: LightGrey,
                                ),
                              ),
                              Text("Gender".tr,
                                  style: TextStyle(color: LightGrey)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                (profile.gender == 1) ? 'ذكر' : (profile.gender == 2 ? 'أنثى' : 'N/A'),
                                style: TextStyle(color: LightGrey),
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
          SizedBox(
            height: 100,
          ),
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
            child:  Column(
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
                            icon: Icons.edit_note_rounded,
                            iconColor: Colors.deepPurpleAccent,
                            textColor: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Divider(),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => RewardWheelScreen(
                              wheelItems: rewardController.WheelItems!,
                              onClose: () {

                              },
                            ));

                          },
                          child: ProfileList(
                            title: 'Wheel of Fortune'.tr,
                            icon:  FontAwesomeIcons.spinner,
                            iconColor: Colors.yellow,
                            textColor: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Divider(),
                        ),
                      ],
                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signinscreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Login".tr,
                        textAlign: TextAlign.center,
                        style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: LightGrey,
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
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
                  child: ProfileList(
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
                  child: ProfileList(
                    icon: Icons.info,
                    title: "App Information".tr,
                    iconColor: Colors.blue,
                    textColor: Colors.black,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                Obx(() {
                  if (tokenController.token.value.isNotEmpty) {
                    final profile = profileController.profile.value;

                    if (profile != null && profile.data != null) {
                      return Column(
                        children: [

                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: "Confirm Delete Account".tr,
                                titleStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                content: TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0.5, end: 1.0),
                                  duration: Duration(milliseconds: 300),
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                      scale: value,
                                      child: Container(
                                        width: 400,
                                        height: 250,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 20),
                                            Text(
                                              "Are you sure you want to Delete Account?".tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 50),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.grey[300],
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                                                    shadowColor: Colors.black.withOpacity(0.1),
                                                    elevation: 5,
                                                  ),
                                                  onPressed: () => Get.back(),
                                                  child: Text(
                                                    "No".tr,
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: PrimaryColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                                                    shadowColor: Colors.black.withOpacity(0.1),
                                                    elevation: 5,
                                                  ),
                                                  onPressed: () {
                                                    profileController.deleteProfile(
                                                      phoneNumber: profile.data?.phoneNumber ?? '',
                                                      verificationCode: box.read('verificationCode'),
                                                      sms: profile.data?.verificationUserType ?? '',
                                                    );
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Yes".tr,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                radius: 15,
                                barrierDismissible: false,
                                backgroundColor: Colors.white,
                              );
                            },
                            child: ProfileList(
                              icon: Icons.delete,
                              title: "Delete Account".tr,
                              iconColor: Colors.red,
                              textColor: Colors.red,
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
                                titleStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                content: TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0.5, end: 1.0),
                                  duration: Duration(milliseconds: 300),
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                      scale: value,
                                      child: Container(
                                        width: 400,
                                        height: 250,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 20),
                                            Text(
                                              "Are you sure you want to Logout?".tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 50),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.grey[300],
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                                                    shadowColor: Colors.black.withOpacity(0.1),
                                                    elevation: 5,
                                                  ),
                                                  onPressed: () => Get.back(),
                                                  child: Text(
                                                    "No".tr,
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: PrimaryColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                                                    shadowColor: Colors.black.withOpacity(0.1),
                                                    elevation: 5,
                                                  ),
                                                  onPressed: () {
                                                    controller.logout();
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Yes".tr,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                radius: 15,
                                barrierDismissible: false,
                                backgroundColor: Colors.white,
                              );
                            },
                            child: ProfileList(
                              icon: Icons.logout,
                              title: "Logout".tr,
                              iconColor: Colors.orangeAccent,
                              textColor: Colors.red,
                            ),
                          ),

                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                  return SizedBox.shrink();
                }),

                SizedBox(height: 50),
              ],
            ),
          )
        ],
      ),
    );
  }
}
