import 'package:flutter/material.dart';

import 'Model/model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Formulário Interativo';
    return MaterialApp(
      title: appTitle,
      home: const MainPage(title: appTitle),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Tema principal
      ),
    );
  }
}
