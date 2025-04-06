import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Services/ServicesScreen.dart';
import 'package:direct_target/Widgets/DoctorListHome.dart';
import 'package:direct_target/Widgets/IconsList.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../../Controller/AllSettingController.dart';
import '../../../Controller/AppointmentController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Controller/TokenController.dart';
import '../../../Model/AllCardServicesModel.dart';
import '../../../Routes/Routes.dart';
import '../../../Service/CardServices.dart';
import '../../../Service/SettingsServices.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';


class HomeContentScreenBody extends StatefulWidget {
  const HomeContentScreenBody({super.key});

  @override
  State<HomeContentScreenBody> createState() => _HomeContentScreenBodyState();
}

class _HomeContentScreenBodyState extends State<HomeContentScreenBody> {
  final tokenController = Get.put(TokenController());
  String? selectedCategory;
  List<Services> selectedServices = [];
  final CardController cardController = Get.put(CardController(CardServices()));
  LoaderController loaderController = Get.put(LoaderController());
  final AppointmentController appointmencontroller =
      Get.put(AppointmentController());
  final AllSettingController _appController =
      Get.put(AllSettingController(SettingsServices()));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(),
            child: TextField(
              onTap: () {
                Get.toNamed(AppRoutes.search);
              },
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.none,
              autofocus: false,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusColor: Colors.black26,
                fillColor: Color.fromARGB(255, 247, 247, 247),
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    child: Icon(
                      Icons.search,
                      size: MediaQuery.of(context).size.height * 0.025,
                      color: Colors.black,
                    ),
                  ),
                ),
                prefixIconColor: PrimaryColor,
                label: Text(
                  "Search doctor, drugs, articles...".tr,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 400,
          child: GetBuilder<CardController>(
            builder: (cardController) {
              if (loaderController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(color: PrimaryColor),
                );
              }

              if (cardController.allCardList!.isEmpty) {
                return Center(
                  child: Text(
                    "No data available".tr,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                );
              }

              return Column(
                children: cardController.allCardList!.map((service) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ServicesScreen(
                            cardId: service.id!));
                      },
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: (service.image != null && service.image!.isNotEmpty)
                              ? ShimmerImage(imageUrl: service.image!)
                              : Image.asset(
                            'Assets/images/4.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.requestcard);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              "Request Card".tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: LightGrey,
                  ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: GetBuilder<CardController>(
            builder: (controller) {
              if (loaderController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(color: PrimaryColor),
                );
              }
              if (controller.categoryList == null ||
                  controller.categoryList!.isEmpty) {
                return Center(
                  child: Text(
                    "No data available".tr,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              String? selectedCategory = controller.selectedCategory;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categoryList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final service = controller
                            .categoryList![index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ServicesScreen(
                                cardId: _appController.appCardValue.value));
                            controller.update();
                          },
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedCategory == service.categoryName
                                  ? PrimaryColor
                                  : _convertHexToColor(service.categoryColor),
                            ),
                            child: Center(
                              child: ListIcons(
                                icon: service.categoryIcon ?? "default",
                                text: service.categoryName ?? "No Name",
                                categoryDiscount: service.categoryDiscount,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      selectedCategory == service.categoryName
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Join Now".tr,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            GetBuilder<CardController>(
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.topdoctor);
                  },
                  child: Text(
                    "See all".tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 220,
          width: 400,
          child: GetBuilder<CardController>(
            builder: (controller) {
              if (loaderController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(color: PrimaryColor),
                );
              }
              if (controller.allServicesList == null) {
                return Center(
                  child: Text(
                    "Loading data...".tr,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              if (controller.allServicesList!.isEmpty) {
                return Center(
                  child: Text(
                    "No data available".tr,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              return ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: controller.allServicesList!.map((service) {
                  return GestureDetector(
                    onTap: () async {
                      await appointmencontroller.canBookAppointment(
                          serviceId: service.id ?? 0);
                    },
                    child: list_doctor1(
                      image: service.image != null && service.image!.isNotEmpty
                          ? service.image!
                          : "Assets/images/person.jpg",
                      maintext: service.serviceName ?? "No Name",
                      subtext: (service.specialty != null && service.specialty!.isNotEmpty)
                          ? "Specialization : ".tr + " " + service.specialty!
                          : "",
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ]),
    );
  }
}

Color _convertHexToColor(String? hexColor) {
  if (hexColor == null || hexColor.isEmpty) {
    return Colors.grey.shade200;
  }

  hexColor = hexColor.replaceAll("#", "");

  if (hexColor.length == 3) {
    hexColor = hexColor.split('').map((char) => "$char$char").join();
  }

  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }

  try {
    return Color(int.parse(hexColor, radix: 16));
  } catch (e) {
    return Colors.grey.shade200;
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
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red),
    );
  }
}
