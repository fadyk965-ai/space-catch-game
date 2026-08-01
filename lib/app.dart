import 'package:flutter/material.dart';
import 'screens/space_game_screen.dart';

class SpaceGameApp extends StatelessWidget {
  const SpaceGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Dodge Ultimate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF030712),
      ),
      home: const SpaceGameScreen(),
    );
  }
}

