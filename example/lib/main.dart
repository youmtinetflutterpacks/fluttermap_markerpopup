import 'package:flutter/material.dart';
import 'package:longpress_popup_example/popup_option_controls.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marker Popup Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: const PopupOptionControls(),
    );
  }
}
