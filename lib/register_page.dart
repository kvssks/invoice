import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String organizationName = '';
  String password = '';
  Uint8List? organizationLogo;
  final ImagePicker _picker = ImagePicker();

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      // Generate a 5-digit hexadecimal organization key
      String organizationKey = Random().nextInt(0xFFFFF).toRadixString(16).padLeft(5, '0').toUpperCase();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Organization Key: $organizationKey')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() async {
        organizationLogo = await pickedFile.readAsBytes();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Organization Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your organization name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    organizationName = value;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Upload Organization Logo'),
                ),
                SizedBox(height: 20),
                organizationLogo != null
                    ? Image.memory(organizationLogo!, height: 100)
                    : Text('No image selected'),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please create a password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
