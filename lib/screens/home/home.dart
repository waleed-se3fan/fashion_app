import 'package:cc/screens/mycart/mycart.dart';
import 'package:cc/screens/profile/profile.dart';
import 'package:cc/screens/wishlist/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/cubit/profile_cubit.dart';
import '../../services/auth_service.dart';
import 'components/home_appbar.dart';
import 'components/most_pupular.dart';
import 'components/product_listview.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            key: _scaffoldState,
            drawer: Drawer(
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  clipBehavior: Clip.antiAlias,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width / 2.7,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: FutureBuilder(
                                      future: cubit.donloadImage(),
                                      builder: (c, s) {
                                        return s.data == null
                                            ? Image.asset(
                                                'images/default-avatar.png')
                                            : Image.network(
                                                s.data.toString(),
                                                fit: BoxFit.contain,
                                              );
                                      })),
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: FutureBuilder(
                                    future: cubit.userName(),
                                    builder: (c, s) {
                                      return Text(
                                        s.data.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: FutureBuilder(
                                    future: cubit.email(),
                                    builder: (c, s) {
                                      return Text(s.data.toString());
                                    }),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person_3_outlined),
                              title: const Text('Profile'),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) {
                                  return ProfileScreen();
                                }));
                              },
                            ),
                            ListTile(
                              leading: Icon(CupertinoIcons.heart),
                              title: Text('Wishlist'),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) {
                                  return WishlistScreen();
                                }));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.card_travel_sharp),
                              title: const Text('Cards'),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) {
                                  return const MyCartScreen();
                                }));
                              },
                            ),
                            const ListTile(
                              leading:
                                  Icon(Icons.notifications_active_outlined),
                              title: Text('Notifications'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text('Logout'),
                              onTap: () async {
                                final sharedpref =
                                    await SharedPreferences.getInstance();
                                sharedpref.remove('log');
                                sharedpref.remove('uid');
                                AuthService().signOut(context);
                              },
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 18, top: 15),
                child: Column(
                  children: [
                    CustomHomeAppBar(_scaffoldState),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Find your style',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 33,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: ProfileCubit.productName.length,
                          itemBuilder: (c, i) {
                            return InkWell(
                              onTap: () {
                                cubit.changeState(i);

                                print(ProfileCubit.myVar);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        radius:
                                            ProfileCubit.myVar == i ? 38 : 30,
                                        backgroundImage: NetworkImage(
                                            ProfileCubit.productImage[i])),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(ProfileCubit.productName[i])
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    ProfileCubit.myVar == 0
                        ? CustomProductListView('Electronics')
                        : ProfileCubit.myVar == 1
                            ? CustomProductListView('Mens Fashion')
                            : CustomProductListView('Girls Fashion'),
                    const MostPopularProducts(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
