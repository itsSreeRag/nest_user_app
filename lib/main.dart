import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/controllers/custometextfield_provider/custometexfield_provider.dart';
import 'package:nest_user_app/controllers/splash_screen_povider/splash_screen_provider.dart';
import 'package:nest_user_app/views/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => MyAuthProviders()),
        ChangeNotifierProvider(create: (_) => CustometexfieldProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MySplashScreen(),
      ),
    );
  }
}
