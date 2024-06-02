import 'package:biblioteca_app/Screens/loginScreen.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:biblioteca_app/providers/reviewProvider.dart';
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
        ChangeNotifierProvider(create: (context) => ProviderLibros()),
        ChangeNotifierProvider(create: (context) => ReviewProvider()),],
      child:  MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          primaryColor: const Color(0xFFE63655),
          hintColor: const Color(0xFF106585),
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Color(0xFF745E4D)),
            bodyText2: TextStyle(color: Color(0xFF745E4D)),
            headline6: TextStyle(color: Color(0xFF106585)),
          ),
          appBarTheme: const AppBarTheme(
            color: Color(0xFFE28B7A),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFE28B7A)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 16)),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}