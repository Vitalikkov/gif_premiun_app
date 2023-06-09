import 'package:flutter/material.dart';
import 'package:gif_premiun_app/src/pages/home.dart';
import 'package:gif_premiun_app/src/pages/saved.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gifanator 3000',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/saves': (context) => Saved(),

      },
    );
  }
}