import 'package:flutter/material.dart';
class doctorList extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;

  doctorList(
      {
      required this.image,
      required this.maintext,
      required this.subtext});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(

              children: [
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1200,
                    width: MediaQuery.of(context).size.width * 0.1200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: AssetImage(image),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1200,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        maintext,
                          style: Theme.of(context).textTheme.bodyLarge
                      ),
                      Text(
                        subtext,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
