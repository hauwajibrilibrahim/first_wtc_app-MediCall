import 'package:first_app/provider/user_notifier.dart';
import 'package:first_app/widgets/custom_button.dart';
import 'package:first_app/widgets/custom_textfield.dart';
import 'package:first_app/widgets/password_textfield.dart';
import 'package:first_app/widgets/social_signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userNotifier = Provider.of<UserNotifier>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    //final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login_bgimage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Welcome Back",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Ready to assist you!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        label: 'Email',
                        textEditingController: emailController,
                      ),
                      const SizedBox(height: 16),
                      PasswordTextField(
                        label: 'Password',
                        textEditingController: passwordController,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() => _isChecked = value ?? false);
                                },
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Text(
                                "Remember me",
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/forgot',
                              );
                            },
                            child: Text(
                              "Forget password?",
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: CustomButton(
                          text: 'Sign in',
                          onPressed: () {
                            /*if (emailController.text != 'jiddah@gmail.com') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not a valid email. Try again')));
                              return;
                            }
                            if(passwordController.text != '123Tech') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not a valid password. Try again')));
                              return;
                            }
                            Navigator.of(context).pushReplacementNamed('/home');*/
                            userNotifier.login(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      SocialSignIn(),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/signup',
                              );
                            },
                            child: Text(
                              "Sign up",
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
