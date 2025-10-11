import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizara/Data/Models/questions_model.dart';
import '../ApiManager/api_manager.dart';

class QuestionProvider extends ChangeNotifier {
  List<Results> questions = [];
  bool isLoading = false;
  int score = 0;

  List<Results> get getQuestion => questions;
  bool get getLoading => isLoading;
  int get getScore => score;


  Future<void> fetchQuestions({
    required int categoryId,
    required String categoryName,
    required String source,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      if (source == 'api') {

        questions = await ApiManager().getQuestions(categoryId);
      } else if (source == 'firebase') {

        final querySnapshot = await FirebaseFirestore.instance
            .collection('quizzes')
            .where('category_name', isEqualTo: categoryName)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final data = querySnapshot.docs.first.data();
          final List<dynamic> questionsList = data['questions'] ?? [];

          questions = questionsList.map((q) {
            final bool answer = q['answer'] == true;
            return Results(
              question: q['question'],
              correctAnswer: answer ? "True" : "False",
              incorrectAnswers: [answer ? "False" : "True"],
              category: categoryName,
              difficulty: 'easy',
              type: 'boolean',
            );
          }).toList();

        } else {
          questions = [];
        }
      }
    } catch (e) {
      debugPrint("Error fetching questions: $e");
      questions = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void addScore() {
    score++;
    notifyListeners();
  }

  void resetScore() {
    score = 0;
    notifyListeners();
  }
}
