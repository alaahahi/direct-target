import 'package:carousel_slider/carousel_slider.dart';
import 'package:direct_target/Screen/Home/HomeContent/HomeContentScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AllSettingController.dart';
import '../../Controller/WheelItemController.dart';
import '../../Routes/Routes.dart';
import '../../Service/SettingsServices.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_version_plus/new_version_plus.dart';

import 'WheelScreen.dart';



class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
  final rewardController = Get.put(WheelItemController());

  void checkVersion(BuildContext context) async {
    print('🧪 Mocked version check for testing...');
    final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
    final appShowPopupUpdate = _controller.appShowPopupUpdate.value;

    if (appShowPopupUpdate) {
      final fakeStatus = VersionStatus(
        localVersion: '1.0.0',
        storeVersion: '2.0.0',
        appStoreLink: 'https://play.google.com/store/apps/details?id=com.direct_target',
      );

      print('🧾 canUpdate: ${fakeStatus.canUpdate}');
      NewVersionPlus().showUpdateDialog(
        context: context,
        versionStatus: fakeStatus,
        dialogTitle: 'New Update Available'.tr,
        dialogText: 'Version'.tr + '${fakeStatus.storeVersion} '+'is available on the store, and you are using version'.tr+'${fakeStatus.localVersion}'+ 'Would you like to update now?'.tr,
        updateButtonText: 'Update'.tr,
        dismissButtonText: 'Later'.tr,
        allowDismissal: true,
      );
    } else {
      print('🔕 Update popup is disabled');
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkVersion(context);

      // جلب بيانات عجلة الحظ وعرضها في نافذة منبثقة عند بدء التطبيق
      rewardController.fetchItems().then((_) {
        if (rewardController.WheelItems != null && rewardController.WheelItems!.isNotEmpty) {
          Get.to(() => RewardWheelScreen(wheelItems: rewardController.WheelItems!, onClose: () {  },));
        }
      });

    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     checkVersion(context);
  //
  //   });
  //
  // }
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



