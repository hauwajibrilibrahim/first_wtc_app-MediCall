import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/model/user_detail.dart';
import 'package:first_app/provider/user_notifier.dart';
import 'package:first_app/widgets/custom_button.dart';
import 'package:first_app/widgets/custom_textfield.dart';
import 'package:first_app/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditPersonalInfoPage extends StatefulWidget {
  const EditPersonalInfoPage({super.key});

  @override
  State<EditPersonalInfoPage> createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  File? _imageFile;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    var user = Provider.of<UserNotifier>(context, listen: false).loggedInUser!;

    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _passwordController = TextEditingController();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _imageFile = File(file.path);
      });
    }
  }

  Future<String?> uploadImage(File img, String email) async {
    try {
      final safeName = email.replaceAll("@", "_").replaceAll(".", "_") + ".jpg";

      final ref = FirebaseStorage.instance
          .ref()
          .child("profilePics")
          .child(safeName);

      await ref.putFile(img);

      return await ref.getDownloadURL();
    } catch (e) {
      print("UPLOAD ERROR: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Image upload failed: $e")));
      return null;
    }
  }

  Future<void> saveInfo() async {
    setState(() => _isSaving = true);

    var provider = Provider.of<UserNotifier>(context, listen: false);
    var user = provider.loggedInUser!;

    String? newImage = user.profilePicture;

    if (_imageFile != null) {
      String? uploaded = await uploadImage(_imageFile!, user.email);
      if (uploaded != null) newImage = uploaded;
    }

    UserDetail updatedUser = UserDetail(
      name: _nameController.text,
      email: user.email,
      profilePicture: newImage,
      phoneNumber: user.phoneNumber,
      address: user.address,
      occupation: user.occupation,
    );

    await provider.updateUserInfo(updatedUser);

    setState(() => _isSaving = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Profile updated successfully")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserNotifier>(context).loggedInUser!;

    return Scaffold(
      appBar: AppBar(title: Text("Edit Personal Info")),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : ((user.profilePicture != null && user.profilePicture?.isNotEmpty == true)
                              ? NetworkImage(user.profilePicture!)
                              : null),
                    child: _imageFile == null && (user.profilePicture?.isEmpty ?? true)
                        ? Icon(Icons.camera_alt, size: 40)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),

              CustomTextField(
                label: 'Name',
                textEditingController: _nameController,
              ),
              SizedBox(height: 16),

              CustomTextField(
                label: 'Email',
                textEditingController: _emailController,
              ),
              SizedBox(height: 16),
              PasswordTextField(
                label: 'New Password',
                textEditingController: _passwordController,
              ),
              const SizedBox(height: 16),

              SizedBox(height: 30),

              CustomButton(onPressed: saveInfo, text: 'Save Changes'),
            ],
          ),

          // ---------------- LOADING OVERLAY ----------------
          if (_isSaving)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
