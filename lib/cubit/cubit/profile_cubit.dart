import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../services/auth_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  static int myVar = 0;

  changeState(i) {
    myVar = i;
    emit(ChangeStateState());
  }

  static List<String> productImage = [
    'https://w7.pngwing.com/pngs/454/1021/png-transparent-consumer-electronics-gadget-advanced-electronics-electronic-component-others-electronics-laptop-electronic-device.png',
    'https://www.dmarge.com/wp-content/uploads/2016/06/gingham.jpg',
    'https://assets.myntassets.com/dpr_1.5,q_60,w_400,c_limit,fl_progressive/assets/images/12769350/2022/8/17/bac1be3a-86a8-4bee-924c-9e33822895d81660739209799CutiekinsGirlsPeach-ColouredGreenPrintedTopwithPalazzos1.jpg'
  ];
  static List<String> productName = [
    'Electronics',
    'Mens Fashion',
    'Girls Fashion'
  ];

  userName() async {
    String? name;

    var data = await (FirebaseFirestore.instance
            .collection('userData')
            .doc(AuthService.userId.toString())
            .get())
        .catchError((e) {
      print(e.toString());
    });
    name = data.data()!['userName'].toString();
    return name;
  }

  email() async {
    String? email;

    var data = await (FirebaseFirestore.instance
            .collection('userData')
            .doc(AuthService.userId.toString())
            .get())
        .catchError((e) {
      print(e.toString());
    });
    email = data.data()!['email'].toString();
    return email;
  }

  password() async {
    String? password;

    var data = await (FirebaseFirestore.instance
        .collection('userData')
        .doc(AuthService.userId.toString())
        .get());
    password = data.data()!['password'].toString();
    return password;
  }

  phone() async {
    String? phone;

    var data = await (FirebaseFirestore.instance
        .collection('userData')
        .doc(AuthService.userId)
        .get());
    phone = data.data()!['phone'].toString();
    return phone;
  }

  var imagePicker = ImagePicker();

  uploadImage(context) async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    File filee = File(image!.path);
    emit(PickCameraState());
    //   File imagePath = File(image.path);

    final imageRef = await FirebaseStorage.instance
        .ref()
        .child(AuthService.userId)
        .putFile(filee)
        .whenComplete(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('uploaded')));
    });
  }

  donloadImage() async {
    try {
      final image = await FirebaseStorage.instance
          .ref()
          .child(AuthService.userId.toString())
          .getDownloadURL()
          .catchError((e) {
        print(e.toString());
      });

      return image.toString();
    } catch (e) {
      return null;
    }
  }

  static bool x = false;
  updateeye() {
    x = !x;
    emit(UpdateEyeState());
  }
}
