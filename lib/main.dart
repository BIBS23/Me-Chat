import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mechat/controllers/access_controller.dart';
import 'package:mechat/controllers/auth_controller.dart';
import 'package:mechat/controllers/message_controller.dart';
import 'package:mechat/controllers/add_user_data.dart';
import 'package:mechat/firebase_options.dart';
import 'package:mechat/screens/home_screen.dart';
import 'package:mechat/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggin = false;

  checkState() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLoggin = true;
        });
      } else {
        setState(() {
          isLoggin = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signout': (context) => const LoginPage(),
      },
      home: isLoggin ? const HomeScreen() : const LoginPage(),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(AddUserData());
        Get.put(AccessStorage());
        Get.put(ChatRoomController());
      }),
    );
  }
}
