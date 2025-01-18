import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Auth/SignIn/SignInScreenBody.dart';

import '../../../Utils/AppStyle.dart';
import 'dart:ui' as ui;
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: SignInScreenBody(),
      ),
    );
  }
}
