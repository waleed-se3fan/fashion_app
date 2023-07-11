import 'package:cc/constants.dart';
import 'package:cc/cubit/cubit/home_cubit.dart';
import 'package:cc/screens/item/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProductListView extends StatelessWidget {
  String type;
  CustomProductListView(this.type);

  @override
  Widget build(context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          var cubit = HomeCubit.get(context);
          return SizedBox(
              height: height(context) / 2.5,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (c, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                          return ItemScreen(i, type);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                FutureBuilder(
                                    future: cubit.getFireImage(i + 1, type),
                                    builder: (c, s) {
                                      return Container(
                                        clipBehavior: Clip.antiAlias,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: s.data == null
                                            ? const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      'images/image_notfound.jpg',
                                                    ),
                                                    fit: BoxFit.fill))
                                            : BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      s.data.toString(),
                                                    ),
                                                    fit: BoxFit.fill)),
                                      );
                                    }),
                              ],
                            ),
                            FutureBuilder(
                                future: cubit.getFireName(i + 1, type),
                                builder: (c, s) {
                                  return s.data == null
                                      ? const Text('wait...')
                                      : SizedBox(
                                          width: width(context) / 3,
                                          child: Text(
                                            s.data.toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ));
                                }),
                            FutureBuilder(
                                future: cubit.getFirePrice(i + 1, type),
                                builder: (c, s) {
                                  return s.data == null
                                      ? const Center(child: Text('wait...'))
                                      : SizedBox(
                                          width: width(context) / 3,
                                          child: Center(
                                            child: Text(
                                              s.data.toString(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ));
                                })
                          ],
                        ),
                      ),
                    );
                  }));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
