import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookAppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book an Appointment".tr)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Select Date and Time".tr, style: TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () {
              },
              child: Text("Book Now".tr),
            ),
          ],
        ),
      ),
    );
  }
}
