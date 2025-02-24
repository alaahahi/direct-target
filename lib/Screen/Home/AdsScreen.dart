
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AdsScreenBody.dart';
import 'CardsScreenBody.dart';


class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  @override
  Widget build(BuildContext context) {
    return  AdsScreenBody();

  }
}
