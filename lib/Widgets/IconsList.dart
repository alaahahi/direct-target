
import 'package:flutter/material.dart';

class ListIcons extends StatelessWidget {
  final String icon;
  final String text;
  final int? categoryDiscount;
  final TextStyle? textStyle;

  ListIcons({
    required this.icon,
    required this.text,
    required this.categoryDiscount,
    this.textStyle,
  });


  IconData? getIconData(String name) {
    Map<String, IconData> iconMap = {
      "home": Icons.home,
      "settings": Icons.settings,
      "search": Icons.search,
      "person": Icons.person,
      "notifications": Icons.notifications,
      "favorite": Icons.favorite,
    };

    return iconMap[name] ?? Icons.help;
  }

  @override
  Widget build(BuildContext context) {
    bool isUrl = icon.startsWith("http");

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 1,
                        color: Color.fromARGB(135, 238, 236, 236),
                      ),
                    ],
                  ),
                  child: isUrl
                      ? Image.network(
                    icon,
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, color: Colors.red);
                    },
                  )
                      : Icon(
                    getIconData(icon),
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      TextStyle(fontSize: 14, color: Colors.black),
                ),
                if (categoryDiscount != null)
                  Text(
                    "$categoryDiscount%",
                    style: textStyle ??
                        TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
