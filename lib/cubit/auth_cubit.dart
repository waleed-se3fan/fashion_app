import 'package:bloc/bloc.dart';
import 'package:cc/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  static bool x = false;
  updateeye() {
    x = !x;
    emit(UpdateEyeState());
  }

  static var userController = TextEditingController();
  static var phoneController = TextEditingController();
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();

  static String? messgae;
  initial() async {
    print('start');
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title);
      print(event.notification!.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Messege Clicked');
    });
  }

  Future signup(username, phoneController, email, password) async {
    await AuthService().signUp(username, phoneController, email, password);
    emit(SignupState());
  }

  static var signInEmailController = TextEditingController();
  static var SignInPasswordController = TextEditingController();

  signin(email, password, context) async {
    await AuthService().sinIn(email, password, context);
  }
}
