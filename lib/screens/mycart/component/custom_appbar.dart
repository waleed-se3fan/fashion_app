import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMycartAppbar extends StatelessWidget {
  String text = '';
  CustomMycartAppbar(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          Center(
            child: Text(text),
          ),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bag))
        ],
      ),
    );
  }
}
