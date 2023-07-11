import 'package:cc/constants.dart';
import 'package:cc/cubit/cubit/home_cubit.dart';
import 'package:cc/screens/mycart/component/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

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

            return Container(
              padding:
                  const EdgeInsets.only(right: 5, left: 5, top: 12, bottom: 20),
              child: Column(
                children: [
                  CustomMycartAppbar('Wishlist'),
                  SizedBox(
                      height: height(context) / 1.5,
                      child: FutureBuilder(
                          future: cubit.getLengthOfCartwishlist(),
                          builder: (context, snapshot) {
                            return HomeCubit.nw == 0
                                ? Image.network(
                                    'https://cdn4.iconfinder.com/data/icons/shopping-actions-2/24/cart_action_shop_store_buy_clear-512.png',
                                    fit: BoxFit.fill,
                                  )
                                : SizedBox(
                                    height: height(context) / 1.7,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data == null
                                            ? 0
                                            : snapshot.data,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: const EdgeInsets.all(30),
                                            height: height(context) / 3,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 10,
                                                  child: FutureBuilder(
                                                      future: cubit
                                                          .getCartImagessWishlist(),
                                                      builder: (c, s) {
                                                        return Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                          child: Image.network(
                                                            s.data == null
                                                                ? 'https://static.vecteezy.com/system/resources/thumbnails/008/255/803/small/page-not-found-error-404-system-updates-uploading-computing-operation-installation-programs-system-maintenance-a-hand-drawn-layout-template-of-a-broken-robot-illustration-vector.jpg'
                                                                : s.data![
                                                                    index],
                                                            fit: BoxFit.fill,
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                Expanded(
                                                  flex: 10,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                            width:
                                                                width(context) /
                                                                    3,
                                                            child:
                                                                FutureBuilder(
                                                                    future: cubit
                                                                        .getCartNamesWishlist(),
                                                                    builder:
                                                                        (c, s) {
                                                                      return Text(
                                                                        s.data ==
                                                                                null
                                                                            ? 'wait...'
                                                                            : s.data![index],
                                                                        style: const TextStyle(
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                      );
                                                                    })),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),

                                                      ////////
                                                      Expanded(
                                                        child: FutureBuilder(
                                                            future: cubit
                                                                .getCartPricesWishlist(),
                                                            builder: (c, s) {
                                                              return Text(s
                                                                          .data ==
                                                                      null
                                                                  ? 'Price : wait...'
                                                                  : 'Price :' +
                                                                      cubit
                                                                          .Pricess[
                                                                              index]
                                                                          .toString());
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
                                                          CupertinoIcons
                                                              .multiply)),
                                                )
                                              ],
                                            ),
                                          );
                                        }));
                          }))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
