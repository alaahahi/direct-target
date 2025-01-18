// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Profile/ProfileScreenBody.dart';

import '../../Utils/AppStyle.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PrimaryColor,
      body: ProfileScreenBody(),
    );
  }
}
