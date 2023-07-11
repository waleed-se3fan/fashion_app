import 'package:cc/constants.dart';
import 'package:cc/screens/home/home.dart';
import 'package:cc/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit/home_cubit.dart';

// ignore: must_be_immutable
class CustomInfo extends StatelessWidget {
  int index = 0;
  String type;
  CustomInfo(this.index, this.type, {super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          var cubit = HomeCubit.get(context);
          return FutureBuilder(
              future: cubit.getFireName(index, type),
              builder: (context, snapshot) {
                HomeCubit.name = snapshot.data.toString();
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: height(context) / 2,
                    width: width(context),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width(context) / 2,
                              child: Text(
                                snapshot.data == null
                                    ? 'wait...'
                                    : snapshot.data.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            FutureBuilder(
                                future: cubit.getFirePrice(index, type),
                                builder: (c, snap) {
                                  HomeCubit.price = snap.data.toString();
                                  return Text(
                                    snapshot.data == null
                                        ? 'wait...'
                                        : snap.data.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  );
                                })
                          ],
                        ),
                        FutureBuilder(
                            future: cubit.getFireRate(index, type),
                            builder: (c, ss) {
                              return Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(ss.data == null
                                      ? 'wait'
                                      : ss.data.toString())
                                ],
                              );
                            })
                        /*    const Text(
                          'Select Size',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: sizes.length,
                              itemBuilder: (c, i) {
                                return InkWell(
                                  onTap: () {
                                    cubit.changeSize(i);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: HomeCubit.sizeIndex == i
                                            ? Colors.orange
                                            : null,
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: HomeCubit.sizeIndex == i
                                                ? .1
                                                : 1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                        child: Text(
                                      sizes[i],
                                      style: TextStyle(
                                          color: HomeCubit.sizeIndex == i
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                  ),
                                );
                              }),
                        ),
                        const Text('Select Color',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              itemBuilder: (c, i) {
                                return InkWell(
                                  onTap: () {
                                    cubit.changeColor(i);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: colors[i],
                                        border: Border.all(
                                            color: HomeCubit.colorIndex == i
                                                ? Colors.deepOrange
                                                : Colors.white,
                                            width: HomeCubit.colorIndex == i
                                                ? 1
                                                : .1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                );
                              }),
                        ),
                       */
                        ,
                        MaterialButton(
                          minWidth: double.infinity,
                          padding: const EdgeInsets.all(20),
                          color: Colors.black,
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection(AuthService.userId.toString())
                                .doc()
                                .set({
                              'name': '${snapshot.data}',
                              'price': '${HomeCubit.price}',
                              'image': '${HomeCubit.image}'
                            });

                            /*HomeCubit.addedItemList.add(CartInfo(
                              snapshot.data![index].image,
                              snapshot.data![index].title,
                              snapshot.data![index].price,
                            ));*/
                            print(HomeCubit.addedItemList.length);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) {
                              return Home();
                            }));
                            /*  Navigator.push(context,
                                MaterialPageRoute(builder: (c) {
                              return MyCartScreen();
                            }));*/
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}

class CartInfo {
  String image;
  String name;
  double price;
  CartInfo(
    this.image,
    this.name,
    this.price,
  );
}
