import 'package:flutter/material.dart';

class Gender extends StatefulWidget {
  final bool isMale;
  final Function onTap;
  Gender(this.isMale, this.onTap);
  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Color(0xfff5d8e4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.isMale == false ? "Female" : "Male",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
