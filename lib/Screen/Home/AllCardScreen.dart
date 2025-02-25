import 'package:direct_target/Screen/Home/AllCardScreenBody.dart';
import 'package:flutter/material.dart';

class AllCardScreen extends StatefulWidget {
  const AllCardScreen({super.key});

  @override
  State<AllCardScreen> createState() => _AllCardScreenState();
}

class _AllCardScreenState extends State<AllCardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AllCardBodyScreen()
    );
  }
}


