import 'package:cc/cubit/auth_cubit.dart';
import 'package:cc/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/sign_up.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/caption_text.dart';
import 'widgets/route_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/title_text.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..initial(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TitleText(
                        text: 'Sign In',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const CaptionText(
                        text: 'welcome back. Please sign in to continue',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                      AuthTextField(
                        icon: Icons.person,
                        text: 'Email',
                        input: TextInputType.name,
                        controller: AuthCubit.signInEmailController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      AuthTextField(
                        SuffixIcon: IconButton(
                          onPressed: () {
                            cubit.updateeye();
                          },
                          icon: AuthCubit.x
                              ? const Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  CupertinoIcons.eye_slash_fill,
                                  color: Colors.grey,
                                ),
                        ),
                        icon: Icons.lock_outline,
                        text: 'Password',
                        passBool: AuthCubit.x ? true : false,
                        controller: AuthCubit.SignInPasswordController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.20,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            onPressed: () async {
                              await cubit.signin(
                                  AuthCubit.signInEmailController.text,
                                  AuthCubit.SignInPasswordController.text,
                                  context);
                              // ignore: use_build_context_synchronously

                              final sharedpref =
                                  await SharedPreferences.getInstance();
                              sharedpref.setString('log', AuthService.message);
                              sharedpref
                                  .setString('uid', AuthService.userId)
                                  .then((value) {
                                print(
                                    'heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey');
                                print(value);
                              });
                            },
                            child: const Text(
                              'Continue',
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('You are new here? '),
                          RouteText(
                              text: 'Sign Up',
                              funtion: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()));
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
