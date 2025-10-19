import 'package:first_app/pages/notifications_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildProfilePics(),
          _buildDetails(),
          SizedBox(height: 16),
          _buildAccountSection(),
          SizedBox(height: 16),
          _buildSupportSection(),
          SizedBox(height: 56),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              )
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            icon: Icon(Icons.logout),
            label: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Column _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Support',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        ListTile(
          title: Text('About Us', style: TextStyle(fontSize: 16.0)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
        Divider(),
        ListTile(
          title: Text('Contact Us', style: TextStyle(fontSize: 16.0)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
      ],
    );
  }

  Column _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        ListTile(
          title: Text('Personal Information', style: TextStyle(fontSize: 16.0)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
        Divider(),
        ListTile(
          title: Text('Payment Methods', style: TextStyle(fontSize: 16.0)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return NotificationsPage();
              }),
            );
          },
          title: Text('Notification', style: TextStyle(fontSize: 16.0)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        Text(
          'Hannah Micheal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        Text(
          'Patient',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          'hannahmail@gmail.com',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePics() {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.hardEdge,
      child: Image.asset('assets/profile_pics.jpg', width: 100, height: 100),
    );
  }
}