import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizara/Data/Provider/question_provider.dart';
import 'package:quizara/UI/QuestionScreen/custom_question.dart';
import '../ScoreScreen/score_screen.dart';

class QuestionScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final List<Color> colors = [
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.blue,
    Colors.pink
  ];

  QuestionScreen({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late List<Color> trueButtonColors;
  late List<Color> falseButtonColors;

  @override
  void initState() {
    super.initState();
    trueButtonColors = List.filled(50, const Color(0xFF90F390));
    falseButtonColors = List.filled(50, const Color(0xFFF17777));
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<QuestionProvider>(context);
    if (provider.questions.isEmpty) {
      Future.microtask(() {
        provider.fetchQuestions(widget.categoryId);
      });
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.orange,
                  Colors.green,
                  Colors.blue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.categoryName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: provider.questions.length + 1,
              itemBuilder: (context, index) {
                if (index < provider.questions.length) {
                  final color = widget.colors[index % widget.colors.length];
                  return CustomQuestionCard(
                    color: color,
                    question: provider.questions[index],
                    trueButtonColor: trueButtonColors[index],
                    falseButtonColor: falseButtonColors[index],
                    onTruePressed: () {
                      setState(() {
                        if (provider.questions[index].correctAnswer?.toLowerCase() == "true") {
                          provider.addScore();
                          trueButtonColors[index] = Colors.green[800]!;
                        } else {
                          falseButtonColors[index] = Colors.red[800]!;
                        }
                      });
                    },
                    onFalsePressed: () {
                      setState(() {
                        if (provider.questions[index].correctAnswer?.toLowerCase() == "false") {
                          provider.addScore();
                          falseButtonColors[index] = Colors.green[800]!;
                        } else {
                          trueButtonColors[index] = Colors.red[800]!;
                        }
                      });
                    },
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "See Score",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScoreScreen()),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
