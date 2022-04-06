import 'package:flutter/material.dart';
import 'Login.dart';
import 'Home.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key?key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'first app',
      initialRoute: '/',
      routes: {
        Login.nameRoute: (context)=>const Login(),
        Home.nameRoute:(context)=>const Home(),
      },
    );
  }
}
