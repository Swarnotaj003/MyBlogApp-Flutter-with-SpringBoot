import 'package:flutter/material.dart';
import 'package:my_blog_app/components/my_snack_bar.dart';
import 'package:my_blog_app/service/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfileForm extends StatefulWidget {
  final String name;
  final String bio;
  final String profilePicture;

  const EditProfileForm({
    super.key, required this.name, required this.bio, required this.profilePicture
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _profilePictureController = TextEditingController();

  // Pre-fill the text fields with existing data
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _bioController.text = widget.bio;
    _profilePictureController.text = widget.profilePicture;
  }

  // Dispose controllers to free up resources
  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _profilePictureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit Profile',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
      ),

      backgroundColor: Colors.white,

      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Name field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name', 
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.brown, width: 2.0),   
                  ),
                ),                
                controller: _nameController,
                validator: (value) => value == null || value.isEmpty ? 'Name cannot be empty' : null,
              ),
                
              // Bio field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.brown, width: 2.0),   
                  ),
                ),
                controller: _bioController,
              ),
                
              // Profile Picture URL field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Profile Picture URL',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.brown, width: 2.0),   
                  ),
                ),
                controller: _profilePictureController,
              ),
            ],
          ),
        ),
      ),

      actions: [
        // Save Button
        MaterialButton(
          onPressed:() {
            if (_formKey.currentState!.validate()) {
              // Save profile changes logic here
              Provider.of<UserProvider>(context, listen: false).updateProfile(
                _nameController.text,
                _bioController.text,
                _profilePictureController.text,
              );
              Navigator.of(context).pop();
              showMySnackBar(context, 'Profile updated successfully!', Colors.green);
            }
          },
          color: Colors.brown,
          elevation: 0,
          child: const Text('Save', style: TextStyle(color: Colors.white)),
        ),

        // Cancel Button
        MaterialButton(
          onPressed:() {
            Navigator.of(context).pop();
          },
          color: Colors.white,
          elevation: 0,
          child: const Text('Cancel', style: TextStyle(color: Colors.brown)),
        ),
      ],
    );
  }
}