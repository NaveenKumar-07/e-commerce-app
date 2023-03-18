import 'package:flutter/material.dart';
import 'package:flutter_application_1/exports.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.id :(context) => const HomePage(),
      },
      initialRoute: HomePage.id,
    );


    
}

}