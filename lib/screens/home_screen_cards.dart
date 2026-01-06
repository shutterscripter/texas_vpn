import 'package:flutter/material.dart';

class HomeScreenCards extends StatelessWidget {
  String title, subtitle;
  Icon icon;

  HomeScreenCards(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: icon,
        ),
        Text(title),
        Text(subtitle),
      ],
    );
  }
}
