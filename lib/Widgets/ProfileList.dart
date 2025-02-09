import 'package:flutter/material.dart';

class ProfileList extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final VoidCallback? onTap;

  ProfileList({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.1500,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 247),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.5800,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        title,
                          style: Theme.of(context).textTheme.titleMedium
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.1100,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
