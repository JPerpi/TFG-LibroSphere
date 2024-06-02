import 'package:biblioteca_app/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:biblioteca_app/providers/usersProvider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final profilePicturePath = usersProvider.profilePicture;
    if (profilePicturePath != null) {
      setState(() {
        _selectedImage = File(profilePicturePath);
      });
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _selectedImage = file;
      });

      final usersProvider = Provider.of<UsersProvider>(context, listen: false);
      await usersProvider.actualizarImagenPerfil(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          PopupMenuButton<String>(
            icon: CircleAvatar(
              backgroundImage: usersProvider.profilePicture != null
                  ? FileImage(File(usersProvider.profilePicture!))
                  : const AssetImage("assets/img/user_icon.png") as ImageProvider,
            ),
            onSelected: (String value) {
              switch (value) {
                case 'settings':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                  break;
                case 'logout':
                  usersProvider.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Ajustes de Usuario'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_selectedImage!),
                  )
                : const Icon(Icons.person, size: 100),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }
}
