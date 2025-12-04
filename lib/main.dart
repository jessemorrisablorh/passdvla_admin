import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pass_dvla_admin/Pages/login_page.dart';
import 'package:pass_dvla_admin/Pages/screen_controller_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Very important!
  final box = GetStorage();
  final isLoggedIn = box.read('isLoggedIn') ?? false;
  if (kDebugMode) {
    print("this is it :: ::$isLoggedIn");
  }
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDcW7q1Os57n2hDnihdgtgexED2Uy0Dc8o",
      authDomain: "dvla-c4355.firebaseapp.com",
      projectId: "dvla-c4355",
      storageBucket: "dvla-c4355.firebasestorage.app",
      messagingSenderId: "541176298336",
      appId: "1:541176298336:web:7d1c8514cec9d79b637c05",
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user = FirebaseAuth.instance.currentUser;

  // bool checked = false;
  // checkAuthentication() {
  //   bool loggedin = box.read("loggedin");
  //   setState(() {
  //     checked = loggedin;
  //   });
  //   print("checked :: $checked");
  // }

  //bool loggedin = box.read("loggedin");

  // final box = GetStorage();
  // box.write("loggedin", false);
  // This widget is the root of your application.
  // @override
  // void initState() {
  //   super.initState();
  //   checkAuthentication();
  // }

  printit() {
    if (kDebugMode) {
      print("THIS IS THE USER ID :: :: ${user?.uid}");
    }
  }

  @override
  void initState() {
    super.initState();
    printit();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pass Dvla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: widget.isLoggedIn == true ? ScreenControllerPage() : LoginPage(),
    );
  }
}
