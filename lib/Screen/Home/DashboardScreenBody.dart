import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Services/Doctor/SearchScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/FindDoctorScreen.dart';
import 'package:direct_target/Widgets/DoctorListHome.dart';
import 'package:direct_target/Widgets/IconsList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:get/get.dart';
import 'package:direct_target/Screen/RequestCard/RequestScreen.dart';


import '../../Controller/LoaderController.dart';
import '../../Controller/TokenController.dart';
import '../../Model/AllCardServicesModel.dart';
import '../../Service/CardServices.dart';
import '../../Widgets/CategoryList.dart';
import '../../Widgets/DoctorList.dart';
import '../Services/Doctor/TopDoctorScreen.dart';
import 'Search.dart';


class DashboardScreenBody extends StatelessWidget {
  DashboardScreenBody({super.key});
  final tokenController = Get.put(TokenController());
  String? selectedCategory;
  List<Services> selectedServices = [];
  final CardController cardController =
  Get.put(CardController(CardServices()));
  LoaderController loaderController = Get.put(LoaderController());
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
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
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:SearchPage()));
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
                  child:Container(
                    child: Icon(
                      Icons.search,
                      size: MediaQuery.of(context).size.height * 0.025,
                      color: Colors.black,
                    ),
                  ),
                ),
                prefixIconColor:PrimaryColor,
                label: Text("Search doctor, drugs, articles...".tr),
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
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: doctor_search(cardId: service.id!),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'Assets/images/4.jpg',
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.cover,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestScreen(),
                ),
              );
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

                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: TopDoctorScreen(),
                      ),
                    );

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
        SizedBox(
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
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              if (controller.allServicesList!.isEmpty) {
                return Center(
                  child: Text(
                    "No data available".tr,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              return ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: controller.allServicesList!.map((service) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: DoctorDetails(doctorId: service.id ?? 0),
                        ),
                      );
                    },
                    child: list_doctor1(
                      image: service.image != null && service.image!.isNotEmpty
                          ? service.image!
                          : "Assets/images/person.png",
                      maintext: service.serviceName ?? "No Name",
                      subtext: service.specialty ?? "No Description",
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
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: GetBuilder<CardController>(
            builder: (controller) {
              if (loaderController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(color: PrimaryColor),
                );
              }
              if (controller.servicesList == null) {
                return Center(
                  child: Text(
                    "Loading data...".tr,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              if (controller.servicesList!.isEmpty) {
                return Center(
                  child: Text(
                    "No data available".tr,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              String? selectedCategory = controller.selectedCategory;
              List<Services> selectedServices = controller.selectedServices;

              if (selectedCategory == null) {
                selectedCategory = controller.servicesList![0].categoryName;
                selectedServices = controller.servicesList![0].services ?? [];
                controller.selectedCategory = selectedCategory;
                controller.selectedServices = selectedServices;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.servicesList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {

                            controller.selectedCategory = controller.servicesList![index].categoryName;
                            controller.selectedServices = controller.servicesList![index].services ?? [];
                            controller.update();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedCategory == controller.servicesList![index].categoryName
                                  ? PrimaryColor
                                  : Colors.grey[200],
                            ),
                            child: Center(
                              child: ListIcons(
                                icon: controller.servicesList![index].categoryIcon ?? "default",
                                text: controller.servicesList![index].categoryName ?? "No Name",
                                categoryDiscount: controller.servicesList![index].categoryDiscount,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selectedCategory == controller.servicesList![index].categoryName
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

                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: selectedServices.length,
                      itemBuilder: (context, index) {
                        var service = selectedServices[index];
                        return GestureDetector(
                          onTap: () {

                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: DoctorDetails(doctorId: service.id!),
                              ),
                            );
                          },
                          child:doctorList(
                            maintext: service.serviceName ?? "No Name",
                            subtext: service.specialty ?? "No Description",
                            image:  "Assets/images/person.png",
                            firstmaintext :service.reviewRate ??  "1",
                          ),

                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ]),
    );

  }
}
