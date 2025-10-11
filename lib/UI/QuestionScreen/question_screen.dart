import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizara/Data/Provider/question_provider.dart';
import 'package:quizara/UI/QuestionScreen/custom_question.dart';
import '../ScoreScreen/score_screen.dart';

class QuestionScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final String source;

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
    required this.source,
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

    Future.microtask(() {
      Provider.of<QuestionProvider>(context, listen: false).fetchQuestions(
        categoryId: widget.categoryId,
        categoryName: widget.categoryName,
        source: widget.source,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<QuestionProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.blue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.categoryName,
                    style: const TextStyle(
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
            margin: const EdgeInsets.only(top: 80),
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.questions.isEmpty
                ? const Center(
              child: Text(
                "No questions found 🧐",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
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
                        final correct = provider.questions[index].correctAnswer;
                        final isCorrect = (correct is bool)
                            ? correct == true
                            : correct.toString().toLowerCase() == "true";
                        if (isCorrect) {
                          provider.addScore();
                          trueButtonColors[index] = Colors.green[800]!;
                        } else {
                          falseButtonColors[index] = Colors.red[800]!;
                        }
                      });
                    },
                    onFalsePressed: () {
                      setState(() {
                        final correct = provider.questions[index].correctAnswer;
                        final isCorrect = (correct is bool)
                            ? correct == false
                            : correct.toString().toLowerCase() == "false";
                        if (isCorrect) {
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
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "See Score",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScoreScreen()),
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
