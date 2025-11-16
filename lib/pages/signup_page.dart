import 'package:first_app/provider/user_notifier.dart';
import 'package:first_app/widgets/custom_button.dart';
import 'package:first_app/widgets/custom_textfield.dart';
import 'package:first_app/widgets/password_textfield.dart';
import 'package:first_app/widgets/social_signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isChecked = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userProv = Provider.of<UserNotifier>(context);
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
                height: screenHeight * 0.8,
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
                        "Get Started",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Register below with your details!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(fontSize: 16),
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(label: 'Username', textEditingController: nameController,),
                      const SizedBox(height: 16),
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
                      PasswordTextField(
                        label: 'Confirm Password',
                        textEditingController: confirmPasswordController,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Text(
                            "I agree to the processing of \n Personal data",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: CustomButton(
                          text: 'Sign up',
                          onPressed: () {
                            /*if (emailController.text != 'jiddah@gmail.com') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Not a valid email. Try again'),
                                ),
                              );
                              return;
                            }
                            if (passwordController.text != '123Tech') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Not a valid password. Try again',
                                  ),
                                ),
                              );
                              return;
                            }
                            if (confirmPasswordController.text != '123Tech') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Password not matched! Try again',
                                  ),
                                ),
                              );
                              return;
                            }
                            Navigator.of(context).pushReplacementNamed('/home');*/
                            userProv.signUp(
                              context: context,
                              userName: nameController.text,
                              password: passwordController.text,
                              email: emailController.text,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      SocialSignIn(),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 3,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              "Sign in",
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
