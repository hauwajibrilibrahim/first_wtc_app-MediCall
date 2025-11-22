import 'dart:io';

import 'package:first_app/model/user_detail.dart';
import 'package:first_app/pages/profile_page.dart';
import 'package:first_app/provider/user_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    var user = Provider.of<UserNotifier>(context, listen: false).loggedInUser!;

    // Pre-fill the fields with current user data
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source, maxWidth: 800, maxHeight: 800, imageQuality: 80);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
    if (!mounted) return;
    // Only pop if still mounted
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(); // close bottom sheet
    }
  }

  void _showPickOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose from Gallery"),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a Photo"),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            if (_imageFile != null)
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Remove"),
                onTap: () {
                  setState(() => _imageFile = null);
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<String?> _uploadProfilePicture(File file) async {
    try {
      final userProvider = Provider.of<UserNotifier>(context, listen: false);
      final user = userProvider.loggedInUser!;
      final uidOrFallback = user.email.isNotEmpty ? user.email : DateTime.now().millisecondsSinceEpoch.toString();
      final fileName = 'profile_${uidOrFallback}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance.ref().child('profile_pictures').child(fileName);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint('Upload failed: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserNotifier>(context);
    var currentUser = userProvider.loggedInUser!;

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
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!) as ImageProvider
                          : (currentUser.profilePicture != null && currentUser.profilePicture!.isNotEmpty)
                              ? NetworkImage(currentUser.profilePicture!)
                              : null,
                      child: (currentUser.profilePicture == null || currentUser.profilePicture!.isEmpty) && _imageFile == null
                          ? Icon(Icons.person, size: 56, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: _showPickOptions,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.edit, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("Name", _nameController),
              _buildTextField("Email", _emailController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isUploading ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isUploading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(
                        "Save",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
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
      setState(() => _isUploading = true);
      var userProvider = Provider.of<UserNotifier>(context, listen: false);

      String? uploadedUrl;
      if (_imageFile != null) {
        uploadedUrl = await _uploadProfilePicture(_imageFile!);
      }

      // Create updated user object
      UserDetail updatedUser = UserDetail(
        name: _nameController.text,
        email: _emailController.text,
        profilePicture: uploadedUrl ?? userProvider.loggedInUser!.profilePicture,
      );

      // Update in Firestore
      await userProvider.updateUserInfo(updatedUser);

      setState(() => _isUploading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Information updated successfully!")),
      );

      Navigator.pushReplacementNamed(
        context,
        '/profile',
      ); // Go back to Profile Page
    }
  }
}
