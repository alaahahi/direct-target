import 'package:carousel_slider/carousel_slider.dart';
import 'package:direct_target/Screen/Home/HomeContent/HomeContentScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Controller/AllSettingController.dart';
import '../../Controller/ProfileCardController.dart';
import '../../Controller/TokenController.dart';
import '../../Controller/WheelItemController.dart';
import '../../Routes/Routes.dart';
import '../../Service/SettingsServices.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_version_plus/new_version_plus.dart';

import 'WheelScreen.dart';

import 'package:package_info_plus/package_info_plus.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
  final rewardController = Get.put(WheelItemController());
  final TokenController tokenController = Get.put(TokenController());
  final box = GetStorage();
  final ProfileCardController profileController =
  Get.put(ProfileCardController());
  Future<String> getLocalVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void checkVersion(BuildContext context) async {
    print('🧪 Check version from API and local device...');
    final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
    final appShowPopupUpdate = _controller.appShowPopupUpdate.value;
    final storeVersion = _controller.appVersion.value;

    if (!appShowPopupUpdate) {
      print('🔕 Update popup is disabled');
      return;
    }

    final localVersion = await getLocalVersion();

    final fakeStatus = VersionStatus(
      localVersion: localVersion,
      storeVersion: storeVersion,
      appStoreLink: 'https://play.google.com/store/apps/details?id=com.direct_target',
    );

    print('📦 Local Version: $localVersion');
    print('🛒 Store Version: $storeVersion');
    print('🧾 canUpdate: ${fakeStatus.canUpdate}');

    if (fakeStatus.canUpdate) {
      NewVersionPlus().showUpdateDialog(
        context: context,
        versionStatus: fakeStatus,
        dialogTitle: 'New Update Available'.tr,
        dialogText: 'Version'.tr + ' ${fakeStatus.storeVersion} ' + 'is available on the store, and you are using version'.tr + ' ${fakeStatus.localVersion}. ' + 'Would you like to update now?'.tr,
        updateButtonText: 'Update'.tr,
        dismissButtonText: 'Later'.tr,
        allowDismissal: true,
      );
    } else {
      print('✅ You have the latest version');
    }
  }



  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkVersion(context);
      await profileController.fetchProfile();
      if (tokenController.token.value.isNotEmpty) {
        rewardController.fetchItems().then((_) {
          int? canLots = profileController.profile.value.data?.canLots;
          print("canLots: $canLots");

          if (canLots == 1 &&
              rewardController.WheelItems != null &&
              rewardController.WheelItems!.isNotEmpty) {
            Get.to(() => RewardWheelScreen(
              wheelItems: rewardController.WheelItems!,
              onClose: () {},
            ));
          } else {
            print("🚫 لا يُسمح بعرض الدولاب. canLots ≠ 1 أو WheelItems فارغة");
          }
        });
      } else {
        print("🚫 لا يوجد تسجيل دخول. لن يتم عرض الدولاب.");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider(
              items: [
                _controller.firstAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.firstAdsImageUrl.value)
                    : Image.asset('Assets/images/1.jpg'),
                _controller.secondAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.secondAdsImageUrl.value)
                    : Image.asset('Assets/images/1.jpg'),
                _controller.thirdAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.thirdAdsImageUrl.value)
                    : Image.asset('Assets/images/1.jpg'),
                _controller.fourthAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.fourthAdsImageUrl.value)
                    : Image.asset('Assets/images/1.jpg'),
              ].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.homescreen);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: item,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 4 / 3,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            HomeContentScreen(),
          ],
        ),
      ),
    );
  }
}

class ShimmerImage extends StatelessWidget {
  final String imageUrl;

  ShimmerImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        child: Container(
          color: Colors.grey[300],
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
    );
  }
}



