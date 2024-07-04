import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'story_creator.dart';

void main() {
  Gemini.init(apiKey: 'AIzaSyA9eVBG52GkqBRY6ThaiJ2N4OAZMvcpzZ8');
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story Creator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const StoryCreator(),
    );
  }
}
