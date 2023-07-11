import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cc/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit/profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  String userName, phone, email, password;

  bool x = false;

  var usercontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  EditProfileScreen(this.userName, this.phone, this.email, this.password);
  Widget textfield({@required hintText, controller, icon}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: icon,
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xff555555),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ProfileCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CustomPaint(
                        child: Container(),
                        painter: HeaderCurvedContainer(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 20),
                        child: const Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 35,
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                          clipBehavior: Clip.antiAlias,
                          height: MediaQuery.of(context).size.height * 0.23,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: FutureBuilder(
                              future: cubit.donloadImage(),
                              builder: (c, s) {
                                return s.data == null
                                    ? Image.asset('images/default-avatar.png')
                                    : Image.network(
                                        s.data.toString(),
                                        fit: BoxFit.cover,
                                      );
                              })),
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await cubit.uploadImage(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 450,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textfield(
                                hintText: userName, controller: usercontroller),
                            textfield(
                                hintText: phone, controller: phonecontroller),
                            textfield(
                                hintText: email, controller: emailcontroller),
                            textfield(
                                hintText:
                                    ProfileCubit.x ? password : '**********',
                                controller: passwordcontroller,
                                icon: IconButton(
                                    onPressed: () {
                                      cubit.updateeye();
                                    },
                                    icon: ProfileCubit.x
                                        ? const Icon(Icons.remove_red_eye)
                                        : const Icon(
                                            CupertinoIcons.eye_slash_fill))),
                            Container(
                              height: 55,
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('userData')
                                      .doc(AuthService.userId.toString())
                                      .update({
                                    'email': emailcontroller.text == ''
                                        ? email
                                        : emailcontroller.text,
                                    'password': passwordcontroller.text == ''
                                        ? password
                                        : passwordcontroller.text,
                                    'phone': phonecontroller.text == ''
                                        ? phone
                                        : phonecontroller.text,
                                    'userName': usercontroller.text == ''
                                        ? userName
                                        : usercontroller.text
                                  }).whenComplete(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Done')));
                                  });
                                },
                                color: Colors.black54,
                                child: const Center(
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );

            /*  Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  child: Container(),
                  painter: HeaderCurvedContainer(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textfield(
                              hintText: userName, controller: usercontroller),
                          textfield(
                              hintText: phone, controller: phonecontroller),
                          textfield(
                              hintText: email, controller: emailcontroller),
                          textfield(
                              hintText:
                                  ProfileCubit.x ? password : '**********',
                              controller: passwordcontroller,
                              icon: IconButton(
                                  onPressed: () {
                                    cubit.updateeye();
                                  },
                                  icon: ProfileCubit.x
                                      ? Icon(Icons.remove_red_eye)
                                      : Icon(CupertinoIcons.eye_slash_fill))),
                          Container(
                            height: 55,
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('userData')
                                    .doc(AuthService.userId)
                                    .update({
                                  'email': emailcontroller.text == ''
                                      ? email
                                      : emailcontroller.text,
                                  'password': passwordcontroller.text == ''
                                      ? password
                                      : passwordcontroller.text,
                                  'phone': phonecontroller.text == ''
                                      ? phone
                                      : phonecontroller.text,
                                  'userName': usercontroller.text == ''
                                      ? userName
                                      : usercontroller.text
                                }).whenComplete(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Done')));
                                });
                              },
                              color: Colors.black54,
                              child: const Center(
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 1.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    
                Padding(
                  padding: const EdgeInsets.only(bottom: 270, left: 184),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await cubit.uploadImage(context);
                      },
                    ),
                  ),
                )
              ],
            );
          */
          },
        ),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
