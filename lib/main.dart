import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:messaging_app/login/login.dart';
// import 'package:messaging_app/login/verify_number.dart';
// import 'package:messaging_app/pages/home.dart';
// import 'package:messaging_app/login/splashPage.dart';

import 'firebase_options.dart';

// const bool USE_EMULATOR = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /*
  if (USE_EMULATOR) {
    _connectToFirestoreEmulator(); 
  }
  
  runApp(MyApp());
  */

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(const MyApp());
}

/*
Future _connectToFirestoreEmulator() async {
  final fireStorePort = "8080";
  final authPort = 9099;
  final localHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
    host: "$localHost:$fireStorePort",
    sslEnabled: false,
    persistenceEnabled: false,
  );
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      // home: VerifyNumber(),
      // home: HomePage(),
      theme: CupertinoThemeData(
          brightness: Brightness.light, primaryColor: Color(0xFF08C187)),
    );
  }
}
