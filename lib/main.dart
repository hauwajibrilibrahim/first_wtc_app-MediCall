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
  await GoogleSignIn.instance.initialize(
    clientId: Platform.isAndroid
        ? "193707534280-jo4u2n3948l5r4abams05urd92fqjcbv.apps.googleusercontent.com"
        : "193707534280-beh7ekjs577gvb21phbdhmrf4ih30sib.apps.googleusercontent.com",
    serverClientId: "193707534280-161j9kn66ua5gifu4vgi9uuohflorm8f.apps.googleusercontent.com",  
    
  );
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
