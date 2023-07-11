import 'package:cc/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit/home_cubit.dart';

class AddedItem extends StatelessWidget {
  const AddedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getLengthOfCart(),
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          var cubit = HomeCubit.get(context);
          return SizedBox(
              height: height(context) / 1.5,
              child: FutureBuilder(
                  future: cubit.getLengthOfCart(),
                  builder: (context, snapshot) {
                    return HomeCubit.n == 0
                        ? Image.network(
                            'https://cdn4.iconfinder.com/data/icons/shopping-actions-2/24/cart_action_shop_store_buy_clear-512.png',
                            fit: BoxFit.fill,
                          )
                        : SizedBox(
                            height: height(context) / 1.7,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    snapshot.data == null ? 0 : snapshot.data,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(30),
                                    height: height(context) / 3,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: FutureBuilder(
                                              future: cubit.getCartImagess(),
                                              builder: (c, s) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  child: Image.network(
                                                    s.data == null
                                                        ? 'https://static.vecteezy.com/system/resources/thumbnails/008/255/803/small/page-not-found-error-404-system-updates-uploading-computing-operation-installation-programs-system-maintenance-a-hand-drawn-layout-template-of-a-broken-robot-illustration-vector.jpg'
                                                        : s.data![index],
                                                    fit: BoxFit.fill,
                                                  ),
                                                );
                                              }),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                    width: width(context) / 3,
                                                    child: FutureBuilder(
                                                        future: cubit
                                                            .getCartNames(),
                                                        builder: (c, s) {
                                                          return Text(
                                                            s.data == null
                                                                ? 'wait...'
                                                                : s.data![
                                                                    index],
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip),
                                                          );
                                                        })),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),

                                              ////////
                                              Expanded(
                                                child: FutureBuilder(
                                                    future:
                                                        cubit.getCartPrices(),
                                                    builder: (c, s) {
                                                      return Text(s.data == null
                                                          ? 'Price : wait...'
                                                          : cubit.Pricess
                                                                  .isEmpty
                                                              ? 'wait...'
                                                              : 'Price :${cubit.Pricess[index]}');
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              onPressed: () {
                                                HomeCubit.addedItemList
                                                    .removeAt(index);
                                              },
                                              icon: const Icon(
                                                  CupertinoIcons.multiply)),
                                        )
                                      ],
                                    ),
                                  );
                                }));
                  }));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}

class PriceItem extends StatelessWidget {
  const PriceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          var cubit = HomeCubit.get(context);
          return Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  ListTile(
                      leading: Text('Sub Total'),
                      trailing: Text(HomeCubit.subtotal == null
                          ? 'wait..'
                          : HomeCubit.subtotal.toString())),
                  ListTile(
                    leading: Text('Shipping'),
                    trailing: FutureBuilder(
                        future: cubit.shipping(),
                        builder: (c, s) {
                          return Text(
                              s.data == 0 ? 'wait..' : s.data.toString());
                        }),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Text('Total'),
                    trailing: FutureBuilder(
                        future: cubit.Total(),
                        builder: (c, s) {
                          return Text(
                              s.data == 0 ? 'wait..' : s.data.toString());
                        }),
                  ),
                  // CustomButton('Checkout', () async {
                  //   print('hello world');
                  //   await FirebaseFirestore.instance
                  //       .collection('Cart')
                  //       .get()
                  //       .then((value) {
                  //     for (final doc in value.docs) {
                  //       print('${doc.id} =>${doc.data()}');
                  //     }
                  //   });
                  //   print('hello world');
                  //   print('hello world');
                  //   print('hello world');
                  // }),
                ],
              ));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
