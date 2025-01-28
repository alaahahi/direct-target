import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/ProfileUserController.dart';


class ProfileView extends StatelessWidget {
  final ProfileUserController controller = Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value.data;
        return profile != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${profile.name ?? 'N/A'}",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text("Phone: ${profile.phoneNumber ?? 'N/A'}",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text("Created At: ${profile.createdAt ?? 'N/A'}",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text("Updated At: ${profile.familyMembersNames ?? 'N/A'}",
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        )
            : Center(child: Text("No profile data found"));
      }),
    );
  }
}
