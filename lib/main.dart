import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizara/UI/Auth/login/login.dart';
import 'Data/Provider/category_provider.dart';
import 'Data/Provider/question_provider.dart';
import 'UI/Auth/sign_up/sing_up.dart';
import 'UI/CategoryScreen/category_screen.dart';
import 'UI/TeacherScreen/teacher_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Firebase apps count: ${Firebase.apps.length}");
  for (var app in Firebase.apps) {
    print("App name: ${app.name}");
  }
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider()..fetchCategories(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuestionProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        Login.routeName: (context) =>  Login(),
        SignUp.routeName: (context) =>  SignUp(),
        TeacherScreen.routeName: (context) => TeacherScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
      },
    );
  }
}
