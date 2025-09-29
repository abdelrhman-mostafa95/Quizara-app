import 'package:dio/dio.dart';
import 'package:quizara/Data/Models/questions_model.dart';

import '../Models/categories_model.dart';

class ApiManager {
  final Dio dio = Dio();

  Future <List<TriviaCategories>> getCategories() async {
    final response = await dio.get('https://opentdb.com/api_category.php');
    final categories = (response.data["trivia_categories"] as List).map((e) =>
        TriviaCategories.fromJson(e)).toList();
    return categories;
  }

  Future<List<Results>> getQuestions(int categoryId) async{
    final response = await dio.get('https://opentdb.com/api.php?amount=10&category=$categoryId&difficulty=medium&type=boolean');
    final questions = (response.data["results"] as List).map((e)=>
    Results.fromJson(e)).toList();
    return questions;
  }
}