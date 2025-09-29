import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizara/UI/HomeScreen/home.dart';

import 'Data/Provider/category_provider.dart';
import 'Data/Provider/question_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CategoryProvider()..fetchCategories(),
      ),
      ChangeNotifierProvider(
        create: (context) => QuestionProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
