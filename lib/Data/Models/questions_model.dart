class Questions {
  Questions({
      this.responseCode, 
      this.results,});

  Questions.fromJson(dynamic json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
  int? responseCode;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = responseCode;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  Results({
      this.type, 
      this.difficulty, 
      this.category, 
      this.question, 
      this.correctAnswer, 
      this.incorrectAnswers,});

  Results.fromJson(dynamic json) {
    type = json['type'];
    difficulty = json['difficulty'];
    category = json['category'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'] != null ? json['incorrect_answers'].cast<String>() : [];
  }
  String? type;
  String? difficulty;
  String? category;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['difficulty'] = difficulty;
    map['category'] = category;
    map['question'] = question;
    map['correct_answer'] = correctAnswer;
    map['incorrect_answers'] = incorrectAnswers;
    return map;
  }

}