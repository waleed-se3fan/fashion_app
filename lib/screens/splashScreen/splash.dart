import 'dart:async';

import 'package:cc/cubit/cubit/home_cubit.dart';
import 'package:cc/screens/authentication/sign_in.dart';
import 'package:cc/screens/home/home.dart';
import 'package:cc/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var logged;
  validate() async {
    final sharedpref = await SharedPreferences.getInstance();
    var log = sharedpref.getString('log');
    var sign = sharedpref.getString('sign');
    setState(() {
      logged = log;
      logged = sign;
    });
    print(logged);

    var token = sharedpref.getString('uid');
    setState(() {
      AuthService.userId = token! ?? '';
    });
    print(AuthService.userId);
  }

  @override
  void initState() {
    validate();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.push(context, MaterialPageRoute(builder: (c) {
          return logged == 'Success' ? Home() : SignInScreen();
        }));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Container(
            height: size.height,
            width: size.width,
            color: Colors.grey,
            child: Center(child: FlutterLogo()),
          );
        },
      ),
    );
  }
}
