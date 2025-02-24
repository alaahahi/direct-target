import 'package:flutter/material.dart';
class CategoryList extends StatelessWidget {

  final String maintext;

  CategoryList(
      {
        required this.maintext,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color.fromARGB(134, 228, 227, 227)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  Text(
                      maintext,
                      style: Theme.of(context).textTheme.bodySmall
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
