
import 'package:flutter/material.dart';

import 'AllCardScreenBody.dart';

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


