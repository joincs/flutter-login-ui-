import 'package:flutter/material.dart';

class HaveAccount extends StatelessWidget {
  final String title, subtitle;
  final Function onTap;
  HaveAccount(this.title, this.subtitle, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        SizedBox(width: 5),
        GestureDetector(
          onTap: onTap,
          child: Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
