import 'package:flutter/material.dart';
class list_doctor1 extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;


  list_doctor1(
      {
        required this.image,
        required this.maintext,
        required this.subtext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 200,
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
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),

                  image: DecorationImage(
                    image: image.isNotEmpty && image.startsWith("http")
                        ? NetworkImage(image)
                        : AssetImage('Assets/images/person.jpg') as ImageProvider,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:  Colors.black,
                      ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    subtext,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:  Colors.grey,
                    ),
                    softWrap:true,
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
