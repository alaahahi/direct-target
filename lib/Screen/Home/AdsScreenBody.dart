import 'package:carousel_slider/carousel_slider.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AllSettingController.dart';
import '../../Service/SettingsServices.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:direct_target/Screen/Home/DashboardScreen.dart';

class AdsScreenBody extends StatefulWidget {
  const AdsScreenBody({super.key});

  @override
  State<AdsScreenBody> createState() => _AdsScreenBodyBodyState();
}

class _AdsScreenBodyBodyState extends State<AdsScreenBody> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider(
              items: [
                _controller.firstAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.firstAdsImageUrl.value)
                    : ShimmerImage(imageUrl: 'Assets/images/2.jpg'),
                _controller.secondAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.secondAdsImageUrl.value)
                    : ShimmerImage(imageUrl: 'Assets/images/2.jpg'),
                _controller.thirdAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.thirdAdsImageUrl.value)
                    : ShimmerImage(imageUrl: 'Assets/images/2.jpg'),
                _controller.fourthAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.fourthAdsImageUrl.value)
                    : ShimmerImage(imageUrl: 'Assets/images/2.jpg'),
              ].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
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
            DashboardScreen(),
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
