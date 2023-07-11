import 'package:cc/screens/authentication/sign_in.dart';
import 'package:cc/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/auth_cubit.dart';
import '../../services/auth_service.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/caption_text.dart';
import 'widgets/route_text.dart';
import 'widgets/title_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
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
                        text: 'Sign Up',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const CaptionText(
                        text: 'welcome!. Please sign up to continue',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                      AuthTextField(
                        icon: Icons.person,
                        text: 'User Name',
                        input: TextInputType.name,
                        controller: AuthCubit.userController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: AuthCubit.phoneController,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            labelText: 'Phone number',
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextField(
                        controller: AuthCubit.emailController,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextField(
                        controller: AuthCubit.passwordController,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true),
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
                              await cubit.signup(
                                  AuthCubit.userController.text,
                                  AuthCubit.phoneController.text,
                                  AuthCubit.emailController.text,
                                  AuthCubit.passwordController.text);
                              final sharedpref =
                                  await SharedPreferences.getInstance();
                              sharedpref.setString('sign', AuthService.message);
                              sharedpref
                                  .setString('uid', AuthService.userId)
                                  .then((value) {
                                print(
                                    'heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey');
                                print(value);
                              });

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AuthService.message)));

                              if (AuthService.message == 'Success') {
                                // ignore: use_build_context_synchronously
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Home();
                                }));
                              }
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
                          const Text('Have an account? '),
                          RouteText(
                              text: 'Sign In',
                              funtion: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen()));
                              })
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
