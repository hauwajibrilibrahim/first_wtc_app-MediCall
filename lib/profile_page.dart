import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'),backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Text('Profile'),
    );
  }
}
