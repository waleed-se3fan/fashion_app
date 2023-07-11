import 'package:cc/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit/home_cubit.dart';

// ignore: must_be_immutable
class CustomMainImage extends StatelessWidget {
  int index;
  String type;
  CustomMainImage(this.index, this.type, {super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          var cubit = HomeCubit.get(context);
          return FutureBuilder(
              future: cubit.getFireImage(index + 1, type),
              builder: (context, snapshot) {
                HomeCubit.image = snapshot.data.toString();
                return Container(
                    clipBehavior: Clip.antiAlias,
                    height: height(context) * .5,
                    width: double.infinity,
                    decoration: snapshot.data == null
                        ? const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('images/image_notfound.jpg'),
                            ),
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(snapshot.data.toString()),
                            ),
                          ));
              });
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
