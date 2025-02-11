// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:direct_target/Screen/Home/DashboardScreen.dart';
// import 'package:direct_target/Screen/Services/ServiceScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Controller/AllSettingController.dart';
// import '../../Service/SettingsServices.dart';
// import 'package:shimmer/shimmer.dart';
// class CardScreenBody extends StatefulWidget {
//   const CardScreenBody({super.key});
//
//   @override
//   State<CardScreenBody> createState() => _CardScreenBodyState();
// }
//
// class _CardScreenBodyState extends State<CardScreenBody> {
//   final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CarouselSlider(
//               items: [
//                 _controller.firstAdsImageUrl.value,
//                 _controller.secondAdsImageUrl.value,
//                 _controller.thirdAdsImageUrl.value,
//                 _controller.fourthAdsImageUrl.value,
//               ].map((item) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Servicescreen(),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                         width: MediaQuery.of(context).size.width,
//                         height: 50,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   height: 150,
//                                   child: ShimmerImage(imageUrl: item), // تطبيق shimmer على الصورة
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }).toList(),
//               options: CarouselOptions(
//                 height: 250,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 aspectRatio: 4 / 3,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 viewportFraction: 0.8,
//               ),
//             ),
//             DashboardScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class ShimmerImage extends StatelessWidget {
//   final String imageUrl;
//
//   ShimmerImage({required this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!, // اللون الأساسي لتأثير shimmer
//       highlightColor: Colors.white, // اللون المميز
//       child: Image.network(
//         imageUrl,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }
