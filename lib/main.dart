import 'package:cc/firebase_options.dart';
import 'package:cc/screens/splashScreen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> fireHandler(RemoteMessage message) async {
  print('Inside function');
  print(message.messageId);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //FirebaseMessaging.onBackgroundMessage(fireHandler);
  /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('this is the real message');
    print(message.messageType);
  });*/

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initial() async {
    await FirebaseMessaging.instance.getToken();
    setState(() {});
  }

  @override
  void initState() {
    //initial();
    // TODO: implement initState
    super.initState();
    // HomeCubit.initial();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

///////////////////Google Map //////////////
/*
class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({super.key});

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  var type = MapType.normal;

  double lat = 5;
  double long = 10;
  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    lat = position.latitude;
    long = position.longitude;
    setState(() {});
    print(position);
  }

  Set<Marker> createMarker() {
    return {
      Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: 'My Location'),
      ),
      const Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(18.997962200185533, 72.8379758747611),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                type = MapType.satellite;
                setState(() {});
              },
              icon: Icon(Icons.share_location_outlined)),
          IconButton(
              onPressed: () {
                getLocation();
              },
              icon: Icon(Icons.location_on)),
        ],
        title: const Text('My Google Map'),
      ),
      body: GoogleMap(
          trafficEnabled: true,
          myLocationEnabled: true,
          mapToolbarEnabled: true,
          mapType: type,
          markers: createMarker(),
          initialCameraPosition: const CameraPosition(
              target: LatLng(19.018255973653343, 72.84793849278007))),
    );
  }
}
*/
/*class Trial extends StatefulWidget {
  const Trial({super.key});

  @override
  State<Trial> createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  getData(x) async {
    String? mydata;
    await Firebase.initializeApp();
    var data = await (FirebaseFirestore.instance
        .collection('Electronics')
        .doc(x.toString())
        .get());
    setState(() {});
    mydata = data.data()!['url'].toString();
    return mydata;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData(0);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FlutterLogo(),
          Container(
            height: 400,
            child: ListView.builder(
                itemCount: 7,
                itemBuilder: (c, i) {
                  return FutureBuilder(
                      future: getData(i + 1),
                      builder: (c, s) {
                        return Image.network(s.data.toString());
                      });
                }),
          )
        ],
      ),
    );
  }
}*/
