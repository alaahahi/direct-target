import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/IconsList.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';




class find_doctor extends StatelessWidget {
  const find_doctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset("Assets/icons/back2.png")),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title: Column(
          children: [
            Text(
              "Find Doctor".tr,
              style:  Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        toolbarHeight: 130,
        elevation: 0,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
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
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.none,
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
                      height: MediaQuery.of(context).size.height * 0.01,
                      width: MediaQuery.of(context).size.width * 0.01,
                      child: Image.asset(
                        "Assets/icons/search.png",
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  prefixIconColor: PrimaryColor,
                  label: Text("Search doctor, drugs, articles...".tr),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Top Doctor".tr,
                  style:  Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              ListIcons(icon: Icons.person, text: "General".tr, color: PrimaryColor),
              ListIcons(icon: Icons.air, text: "Lungs Prob".tr, color: PrimaryColor),
              ListIcons(icon: Icons.healing, text: "Dentist".tr, color: PrimaryColor),
              ListIcons(icon: Icons.psychology, text: "Psychiatrist".tr, color:PrimaryColor),

            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              ListIcons(icon: Icons.coronavirus, text: "Covid".tr, color: PrimaryColor),
              ListIcons(icon: Icons.vaccines, text: "Injection".tr, color: PrimaryColor),
              ListIcons(icon: Icons.favorite, text: "Cardiologist".tr, color: PrimaryColor),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Recommended Doctors".tr,
                  style:  Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Your Recent Doctors".tr,
                  style:  Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1400,
                width: MediaQuery.of(context).size.width * 0.2900,
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.100,
                    width: MediaQuery.of(context).size.width * 0.1900,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("Assets/icons/male-doctor.png"),
                            filterQuality: FilterQuality.high)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(
                        "Dr. Marcus".tr
                    )],
                  )
                ]),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1400,
                width: MediaQuery.of(context).size.width * 0.2900,
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.100,
                    width: MediaQuery.of(context).size.width * 0.1900,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("Assets/icons/female-doctor.png"),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Dr. Maria")],
                  )
                ]),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1400,
                width: MediaQuery.of(context).size.width * 0.2900,
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.100,
                    width: MediaQuery.of(context).size.width * 0.1900,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              "Assets/icons/black-doctor.png",
                            ),
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Dr. Luke")],
                  )
                ]),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
