import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/categories_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadQuiz({
    required String categoryName,
    required List<Map<String, dynamic>> questionsData,
  }) async {
    final quizData = {
      "category_name": categoryName.trim(),
      "questions": questionsData,
    };
    await _db.collection('quizzes').add(quizData);
  }

  Future<List<Category>> getFirebaseCategories() async {
    try {
      final querySnapshot = await _db.collection('quizzes').get();

      final List<Category> firebaseCategories = querySnapshot.docs.map((doc) {
        final data = doc.data();
        final categoryName = data['category_name'] as String?;

        if (categoryName != null && categoryName.isNotEmpty) {
          // ⬅️ إنشاء كائن Category موحد من بيانات Firebase
          return Category(
            id: null, // لا يوجد ID
            name: categoryName,
            source: 'firebase', // تحديد المصدر يدويًا
          );
        }
        // إرجاع قيمة غير صالحة ليتم تصفيتها
        return Category(name: 'Invalid', source: 'invalid');
      }).where((cat) => cat.source != 'invalid').toList(); // تصفية

      // استخدام Set لإزالة التكرارات
      return firebaseCategories.toSet().toList();

    } catch (e) {
      print("Error fetching Firebase categories: $e");
      return [];
    }
  }
}