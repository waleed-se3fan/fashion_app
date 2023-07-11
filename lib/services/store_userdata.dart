import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  storeUserData(uid, username, phone, email, password) async {
    await FirebaseFirestore.instance.collection('userData').doc(uid).set({
      'userName': username,
      'email': email,
      'password': password,
      'phone': phone
    });
  }
}
