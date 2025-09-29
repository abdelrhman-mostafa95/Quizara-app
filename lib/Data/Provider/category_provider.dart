import 'package:flutter/material.dart';
import 'package:quizara/Data/Models/categories_model.dart';

import '../ApiManager/api_manager.dart';

class CategoryProvider extends ChangeNotifier{
  List<TriviaCategories> categories = [];
  bool isLoading = false;

  List<TriviaCategories> get getCategories => categories;
  bool get getLoading => isLoading;

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();
    categories = await ApiManager().getCategories();
    isLoading = false;
    notifyListeners();
  }
}