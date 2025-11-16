import 'package:first_app/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
     var userP = Provider.of<UserNotifier>(context);
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Text(
                'Sign in with',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                 userP.signInWithGoogle(context);
              },
              child: Image.asset(
                'assets/google.png',
                width: 50,
                height: 50,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/fb.png',
                width: 50,
                height: 50,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/x.png',
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
