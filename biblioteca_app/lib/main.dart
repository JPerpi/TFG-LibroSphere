import 'package:biblioteca_app/Screens/loginScreen.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => ProviderLibros()),],
      child: const MaterialApp(
        title: 'Material App',
        home: LoginScreen(),
      ),
    );
  }
}