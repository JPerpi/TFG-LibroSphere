import 'package:biblioteca_app/Screens/login.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UsersProvider(),
        child: MaterialApp(
      title: 'Material App',
      home: LoginScreen(),
      ),
    );
  }
}