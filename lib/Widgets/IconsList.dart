import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
class ListIcons extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  ListIcons({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.15,
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
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                text,
                style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
