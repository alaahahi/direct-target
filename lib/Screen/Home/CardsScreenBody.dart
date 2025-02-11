import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AllSettingController.dart';
import '../../Service/SettingsServices.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:direct_target/Screen/Services/ServiceScreen.dart';
import 'package:direct_target/Screen/Home/DashboardScreen.dart';

class CardScreenBody extends StatefulWidget {
  const CardScreenBody({super.key});

  @override
  State<CardScreenBody> createState() => _CardScreenBodyState();
}

class _CardScreenBodyState extends State<CardScreenBody> {
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
                    : ShimmerImage(imageUrl: 'Assets/images/2.jpg'), // صورة افتراضية
                _controller.secondAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.secondAdsImageUrl.value)
                    : ShimmerImage(imageUrl: 'Assets/images/2.jpg'), // صورة افتراضية
                _controller.thirdAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.thirdAdsImageUrl.value)
                    : ShimmerImage(imageUrl: 'Assets/images/2.jpg'), // صورة افتراضية
                _controller.fourthAdsImageUrl.value.isNotEmpty
                    ? ShimmerImage(imageUrl: _controller.fourthAdsImageUrl.value)
                    : ShimmerImage(imageUrl: 'Assets/images/2.jpg'), // صورة افتراضية
              ].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Servicescreen()),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: item, // الآن العناصر هي Widgets جاهزة للعرض
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
        baseColor: Colors.grey[300]!, // اللون الأساسي لتأثير shimmer
        highlightColor: Colors.white, // اللون المميز
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
