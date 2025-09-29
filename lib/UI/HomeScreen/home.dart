import 'package:flutter/material.dart';

import '../CategoryScreen/category_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
              Colors.green,
              Colors.blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 500),
                child: Text(
                  "Welcome Again",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(seconds: 2),
                child: Text(
                  "New Quiz is Waiting for You",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 100),
              Center(
                child: AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 2),
                    child: Image.asset("assets/images/home.png")),
              ),
              Spacer(),
              Center(
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(seconds: 2),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CategoryScreen())
                        );
                      },

                      child: Text("Get Started",style: TextStyle(
                        color: Color(0xFF060B26),
                        fontSize: 20,
                      ), ),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
