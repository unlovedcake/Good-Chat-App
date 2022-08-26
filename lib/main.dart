import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_chat_app/Provider/auth-provider.dart';
import 'package:good_chat_app/Provider/theme-provider.dart';
import 'package:provider/provider.dart';
import 'Pages/LoginAndRegister/login.dart';
import 'Theme/theme.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home:  Login(),
      debugShowCheckedModeBanner: false,
      color: Colors.indigo[900],
    );
  }
}