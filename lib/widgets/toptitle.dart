import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  TopTitle(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
