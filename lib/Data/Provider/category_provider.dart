import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizara/Data/Models/categories_model.dart';
import '../ApiManager/api_manager.dart';


class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  bool isLoading = false;

  bool get getLoading => isLoading;

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();

    try {

      final apiCategoriesData = await ApiManager().getCategories();
      final apiCategories =
      apiCategoriesData.map((e) => Category.fromApi(e)).toList();

      final firebaseSnapshot =
      await FirebaseFirestore.instance.collection('quizzes').get();

      final firebaseCategories = firebaseSnapshot.docs.map((doc) {
        final data = doc.data();
        return Category(
          id: null,
          name: data['category_name'] ?? "Unnamed Category",
          source: 'firebase',
        );
      }).toList();


      categories = [...apiCategories, ...firebaseCategories];

      debugPrint("API categories: ${apiCategories.length}");
      debugPrint("Firebase categories: ${firebaseCategories.length}");
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
