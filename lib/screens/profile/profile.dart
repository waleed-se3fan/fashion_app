import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubit/cubit/profile_cubit.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  String? userName, phone, email, password;

  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
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
            return Stack(
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
                          ListTile(
                            leading: Text('Username'),
                            trailing: FutureBuilder(
                                future: cubit.userName(),
                                builder: (c, s) {
                                  userName = s.data.toString();
                                  return Text(s.data.toString());
                                }),
                          ),
                          ListTile(
                            leading: Text('Email'),
                            trailing: FutureBuilder(
                                future: cubit.email(),
                                builder: (c, s) {
                                  email = s.data.toString();
                                  return Text(s.data.toString());
                                }),
                          ),
                          ListTile(
                            leading: Text('Phone number'),
                            trailing: FutureBuilder(
                                future: cubit.phone(),
                                builder: (c, s) {
                                  phone = s.data.toString();
                                  return Text(s.data.toString());
                                }),
                          ),
                          ListTile(
                            leading: Text('password'),
                            trailing: FutureBuilder(
                                future: cubit.password(),
                                builder: (c, s) {
                                  password = s.data.toString();
                                  return Text('*******************');
                                }),
                          ),
                          Container(
                            height: 55,
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) {
                                  return EditProfileScreen(
                                      userName!, phone!, email!, password!);
                                }));
                              },
                              color: Colors.black54,
                              child: const Center(
                                child: Text(
                                  "Edit",
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
                    Container(
                        clipBehavior: Clip.antiAlias,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
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
                  ],
                ),
              ],
            );
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
