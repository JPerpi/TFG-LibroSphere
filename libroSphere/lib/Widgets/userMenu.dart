import 'dart:io';
import 'package:flutter/material.dart';
import 'package:biblioteca_app/Screens/settingsScreen.dart';
import 'package:biblioteca_app/Screens/loginScreen.dart';
import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:provider/provider.dart';

class UserMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    return PopupMenuButton<String>(
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
    );
  }
}
