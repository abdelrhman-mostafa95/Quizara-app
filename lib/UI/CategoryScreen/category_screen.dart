import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizara/Data/Provider/category_provider.dart';
import 'package:quizara/UI/QuestionScreen/question_screen.dart';
import 'custom_button.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName= "/student";


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
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: provider.getLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: const [
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
              const SizedBox(height: 20),


              if (provider.categories.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      "No categories found.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              else

                Expanded(
                  child: ListView.builder(
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) {
                      final category = provider.categories[index];
                      final color = colors[index % colors.length];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomButton(
                          text: category.name,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionScreen(
                                  categoryId: provider.categories[index].id ?? 0,
                                  categoryName: provider.categories[index].name ?? "",
                                  source: provider.categories[index].source, // 👈 أضف هذا
                                ),
                              ),
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
