// TODO Implement this library.

import 'package:flutter/material.dart';

class ServiceList extends StatelessWidget {
  final String serviceName;
  final String description;

  const ServiceList({required this.serviceName, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        title: Text(
          serviceName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 14),
        ),
        leading: Icon(Icons.health_and_safety),
      ),
    );
  }
}
