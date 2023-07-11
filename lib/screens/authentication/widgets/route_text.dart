import 'package:flutter/material.dart';

class RouteText extends StatelessWidget {
  final String? text;
  final Function()? funtion;

  const RouteText({this.text, required this.funtion});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: funtion,
        child: Text(
          text!,
          style: TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
        ));
  }
}
