import 'package:cc/cubit/cubit/home_cubit.dart';
import 'package:cc/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/added_items.dart';
import 'component/custom_appbar.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit()
          ..getCartPrices()
          ..getCartNames(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    right: 5, left: 5, top: 12, bottom: 20),
                child: Column(
                  children: [
                    CustomMycartAppbar('My Cart'),
                    AddedItem(),
                    // MaterialButton(
                    //   onPressed: () async {
                    //     await cubit.getCartPrices();

                    //     await cubit.subTotal(HomeCubit.Prices);
                    //     showModalBottomSheet(
                    //         context: context,
                    //         builder: (c) {
                    //           return PriceItem();
                    //         });

                    // await FirebaseFirestore.instance
                    //     .collection('Cart')
                    //     .get()
                    //     .then((value) {
                    //   for (final doc in value.docs) {
                    //     print('${doc.data()}');
                    //   }
                    // });
                    //},
                    //   child: Text('data'),
                    // ),
                    // MaterialButton(
                    //   onPressed: () async {
                    //     await cubit.getCartPrices();
                    //     await cubit.subTotal(HomeCubit.Prices);
                    //   },
                    //   child: Text('GET'),
                    // ),
                    // FutureBuilder(
                    //     future: cubit.getCartPrices(),
                    //     builder: (c, s) {
                    //       return Text(
                    //           s.data == null ? 'wait' : s.data.toString());
                    //     }),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () async {
                          await cubit.getCartPrices();

                          await cubit.subTotal(cubit.Pricess);
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return PriceItem();
                              });
                        },
                        color: Colors.black54,
                        child: const Center(
                          child: Text(
                            "Get Price",
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        FirebaseMessaging.instance.getToken().then((value) {
                          print(value.toString());
                          print(value!.length.toString());
                        }).catchError((c) {
                          print(c.toString());
                        });
                      },
                      child: Text('555'),
                    ),
                    /*  StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Electronics')
                            .where('name', isGreaterThanOrEqualTo: 'Soundcore')
                            .snapshots(),
                        builder: (c, s) {
                          var docs = s.data!.docs[0].data().toString();
                          return Text(
                              s.data == null ? 'wait...' : docs.toString());
                        })*/
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
