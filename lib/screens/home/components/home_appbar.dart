import 'package:cc/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomHomeAppBar extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  CustomHomeAppBar(this._scaffoldState);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  _scaffoldState.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu)),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.bag)),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProfileScreen();
                      }));
                    },
                    icon: const Icon(CupertinoIcons.profile_circled))
              ],
            )
          ],
        ),
      ),
    );
  }
}
