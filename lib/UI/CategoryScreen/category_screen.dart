import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizara/Data/Provider/category_provider.dart';
import 'package:quizara/UI/QuestionScreen/question_screen.dart';

import 'custom_button.dart';

class CategoryScreen extends StatefulWidget {


  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Color> colors = [
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.blue,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context);

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
        child: provider.isLoading
            ?  Center(child: CircularProgressIndicator())
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              SizedBox(height:30),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
               SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    final color = colors[index % colors.length];
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomButton(
                        text: provider.categories[index].name ?? "",
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  QuestionScreen(categoryId: provider.categories[index].id ?? 0,
                                      categoryName: provider.categories[index].name ?? ""))
                          );
                        },
                        color: color,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
