import 'package:cc/cubit/cubit/home_cubit.dart';
import 'package:cc/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemAppBar extends StatelessWidget {
  const ItemAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 33),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection(AuthService.userId.toString() + 'wishlist')
                      .doc()
                      .set({
                    'name': '${HomeCubit.name}',
                    'price': '${HomeCubit.price}',
                    'image': '${HomeCubit.image}'
                  });
                },
                icon: const Icon(Icons.favorite_border_rounded))
          ],
        ),
      ),
    );
  }
}
