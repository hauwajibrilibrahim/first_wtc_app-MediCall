import 'package:first_app/model/user_detail.dart';
import 'package:first_app/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPersonalInfoPage extends StatefulWidget {
  const EditPersonalInfoPage({super.key});

  @override
  State<EditPersonalInfoPage> createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _occupationController;

  @override
  void initState() {
    super.initState();
    var user = Provider.of<UserNotifier>(context, listen: false).loggedInUser!;

    // Pre-fill the fields with current user data
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phoneNumber);
    _addressController = TextEditingController(text: user.address);
    _occupationController = TextEditingController(text: user.occupation);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Personal Information"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Name", _nameController),
              _buildTextField("Email", _emailController),
              _buildTextField("Phone Number", _phoneController),
              _buildTextField("Address", _addressController),
              _buildTextField("Occupation", _occupationController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label cannot be empty";
          }
          return null;
        },
      ),
    );
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      var userProvider = Provider.of<UserNotifier>(context, listen: false);

      // Create updated user object
      UserDetail updatedUser = UserDetail(
        name: _nameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        occupation: _occupationController.text,
        profilePicture: userProvider.loggedInUser!.profilePicture,
      );

      // Update in Firestore
      await userProvider.updateUserInfo(updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Information updated successfully!")),
      );

      Navigator.pop(context); // Go back to Profile Page
    }
  }
}
