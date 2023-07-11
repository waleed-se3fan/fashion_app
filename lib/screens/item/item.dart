import 'package:cc/screens/item/component/item_info.dart';
import 'package:cc/screens/item/component/main_image.dart';
import 'package:flutter/material.dart';

import 'component/item_appbar.dart';

class ItemScreen extends StatelessWidget {
  int index;
  String type;
  ItemScreen(this.index, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomMainImage(index, type),
          ItemAppBar(),
          CustomInfo(index, type),
        ],
      ),
    );
  }
}
