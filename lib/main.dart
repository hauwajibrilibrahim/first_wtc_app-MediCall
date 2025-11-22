import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/bottom_navigation.dart';
import 'package:first_app/pages/contact_page.dart';
import 'package:first_app/pages/forgot_password_page.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:first_app/pages/onboarding_page.dart';
import 'package:first_app/pages/signup_page.dart';
import 'package:first_app/provider/hospital_notifier.dart';
import 'package:first_app/firebase_options.dart';
import 'package:first_app/provider/user_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> HospitalNotifier(),
      child: ChangeNotifierProvider(
        create: (context) => UserNotifier(),
        child: MaterialApp(
          title: 'Save a Life',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => OnboardingPage(),
            '/home': (context) => BottomNavigation(),
            '/login':(context) => LoginPage(),
            '/signup': (context) => SignupPage(),
            '/contact': (context) => ContactPage(),
            '/forgot': (context) => ForgotPasswordPage()
          },
          initialRoute: '/',
        ),
      ),
    );
  }
}
