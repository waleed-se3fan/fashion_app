import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cc/model/item_model.dart';
import 'package:cc/screens/item/component/item_info.dart';
import 'package:cc/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  static String price = '';
  static String image = '';
  static String name = '';
  static initial() async {
    print('This is messeging');
    await FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title.toString());
      print(event.notification!.body);
      print(event.notification.toString());
      print('Done');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Messege Clicked..');
    });
  }

  getFirePrice(x, type) async {
    String? mydata;
    var data = await (FirebaseFirestore.instance
            .collection(type)
            .doc(x.toString())
            .get())
        .catchError((e) {
      print(e.toString());
    });
    mydata = await data.data()!['price'].toString();
    return mydata;
  }

  getFireName(x, type) async {
    String? mydata;
    var data = await (FirebaseFirestore.instance
            .collection(type)
            .doc(x.toString())
            .get())
        .catchError((e) {
      print(e.toString());
    });
    mydata = await data.data()!['name'].toString();
    /*            --------------------------------------------------                            */

    return mydata;
  }

  getFireImage(x, type) async {
    String? mydata;
    var data = await (FirebaseFirestore.instance
            .collection(type)
            .doc(x.toString())
            .get())
        .catchError((e) {
      print(e.toString());
    });

    mydata = await data.data()!['url'].toString();
    return mydata;
  }

  getFireRate(x, type) async {
    String? mydata;
    var data = await (FirebaseFirestore.instance
            .collection(type)
            .doc(x.toString())
            .get())
        .catchError((e) {
      print(e.toString());
    });

    mydata = await data.data()!['rate'].toString();
    return mydata;
  }

  static int sizeIndex = 0;

  static int colorIndex = 0;

  void changeSize(i) {
    HomeCubit.sizeIndex = i;
    emit(ChangeSizeState());
  }

  void changeColor(i) {
    HomeCubit.colorIndex = i;
    emit(ChangeColorsState());
  }

  bool x = true;

  static List<CartInfo> addedItemList = [];
  static int NumberOFCart = 0;
  static List cartImages = [];
  getCartsNumber() async {
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString())
        .get()
        .then((value) {
      NumberOFCart = value.docs.length;
      return value.docs.length;
    }).catchError((e) {
      print(e.toString());
    });
  }

  getCartImages() async {
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString())
        .get()
        .then((value) {
      for (final doc in value.docs) {
        addedItemList = doc.data()['image'];
        print(doc.data()['image']);
        print(addedItemList);
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  List h = [];

  nuberOfCollection() async {
    print('object');
    int documents = await FirebaseFirestore.instance
        .collection(AuthService.userId.toString())
        .snapshots()
        .length
        .then((value) {
      print(value.toString());
      return value;
    }).catchError((e) {
      print(e.toString());
    });
    return documents;
  }

  Future<List> getCartImagess() async {
    List<String> images = [];
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString())
        .get()
        .then((value) {
      return value.docs.forEach((element) {
        images.add(element.data()['image'].toString());
      });
    }).catchError((e) {
      print(e.toString());
    });
    return images;

    // await FirebaseFirestore.instance.collection('Cart').get().then((value) {
    //   for (final doc in value.docs) {
    //     a = doc.data()['image'];
    //   }
    // });
  }

  Future<List> getCartNames() async {
    List<String> names = [];

    print('Hello world');
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        names.add(element.data()['name'].toString());
      });
      return names;
    }).catchError((e) {
      print(e.toString());
    });
    return names;
    // await FirebaseFirestore.instance.collection('Cart').get().then((value) {
    //   for (final doc in value.docs) {
    //     a = doc.data()['image'];
    //   }
    // });
  }

  List Pricess = [];
  Future<List> getCartPrices() async {
    try {
      List<String> Prices = [];
      Pricess = Prices;
      if (Prices.length == 0) {
        await FirebaseFirestore.instance
            .collection(AuthService.userId.toString())
            .get()
            .then((value) async {
          value.docs.forEach((element) async {
            Prices.add(element.data()['price'].toString());
          });
        }).catchError((e) {
          print(e.toString());
        });
      } else {
        print(Prices);
      }
      return Prices;
    } catch (e) {
      return [e.toString()];
    }
  }

  static double subtotal = 0;

  double subTotal(pricesList) {
    double sum = 0;
    for (var x = 0; x < pricesList.length; x++) {
      String f = pricesList[x].trim().substring(1);
      double n = double.parse(f);
      sum = (n += sum);
    }
    subtotal = sum;
    print(sum);
    return sum;
  }

  Future<int> shipping() async {
    // int shipp = await Pricess.length;
    return n * 5;
  }

  Future<double> Total() async {
    // int shipp = await Pricess.length;
    return (n * 5) + subtotal;
  }

  /* shared preferences */

  static String k = '';
  static Future<bool> saveUserData(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(k, value);
  }

  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getBool(k);
  }

  bool f = false;
  void _loadCheck() async {
    final prefs = await SharedPreferences.getInstance();
    f = (prefs.getBool('check') ?? false);
  }

  changeCheck() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('check', true);
    print(f);
  }

  static int n = 0;
  Future<int> getLengthOfCart() async {
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString())
        .get()
        .then((value) async {
      n = value.docs.length;
    });
    print(n);
    return n;
  }

  vvv(index) async {
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString())
        .get()
        .then((value) async {
      print(value.docs[0]['image']);
    });
  }

  Future<List> getCartImagessWishlist() async {
    List<String> imagesWishlist = [];
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString() + 'wishlist')
        .get()
        .then((value) {
      return value.docs.forEach((element) {
        imagesWishlist.add(element.data()['image'].toString());
      });
    });
    return imagesWishlist;

    // await FirebaseFirestore.instance.collection('Cart').get().then((value) {
    //   for (final doc in value.docs) {
    //     a = doc.data()['image'];
    //   }
    // });
  }

  Future<List> getCartNamesWishlist() async {
    List<String> namesWishlist = [];

    print('Hello world');
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString() + 'wishlist')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        namesWishlist.add(element.data()['name'].toString());
      });
      return namesWishlist;
    });
    return namesWishlist;
    // await FirebaseFirestore.instance.collection('Cart').get().then((value) {
    //   for (final doc in value.docs) {
    //     a = doc.data()['image'];
    //   }
    // });
  }

  Future<List> getCartPricesWishlist() async {
    List<String> PricesWishlist = [];
    if (PricesWishlist.length == 0) {
      await FirebaseFirestore.instance
          .collection(AuthService.userId.toString() + 'Wishlist')
          .get()
          .then((value) async {
        value.docs.forEach((element) async {
          PricesWishlist.add(element.data()['price'].toString());
        });
      });
    } else {
      print(PricesWishlist);
    }
    return PricesWishlist;

    // await FirebaseFirestore.instance.collection('Cart').get().then((value) {
    //   for (final doc in value.docs) {
    //     a = doc.data()['image'];
    //   }
    // });
  }

  static int nw = 0;
  Future<int> getLengthOfCartwishlist() async {
    await FirebaseFirestore.instance
        .collection(AuthService.userId.toString() + 'wishlist')
        .get()
        .then((value) async {
      nw = value.docs.length;
    });
    print(nw);
    return nw;
  }

  Future gg() async {
    try {
      var x = await FirebaseFirestore.instance
          .collection('Electronics')
          .where('name', isGreaterThanOrEqualTo: 'Seagate')
          .snapshots();
      return;
    } catch (e) {
      print('Error');
      print(e.toString());
    }
  }
}
