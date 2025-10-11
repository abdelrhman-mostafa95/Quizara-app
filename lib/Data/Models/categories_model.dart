class Categories {
  Categories({
    this.triviaCategories,
  });

  Categories.fromJson(dynamic json) {
    if (json['trivia_categories'] != null) {
      triviaCategories = [];
      json['trivia_categories'].forEach((v) {
        triviaCategories?.add(TriviaCategories.fromJson(v));
      });
    }
  }
  List<TriviaCategories>? triviaCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (triviaCategories != null) {
      map['trivia_categories'] =
          triviaCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TriviaCategories {
  TriviaCategories({
    this.id,
    this.name,
  });

  TriviaCategories.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Category {
  final int? id;
  final String name;
  final String source;

  Category({
    this.id,
    required this.name,
    this.source = 'api',
  });

  factory Category.fromApi(TriviaCategories apiCategory) {
    return Category(
      id: apiCategory.id,
      name: apiCategory.name ?? "Unknown Category",
      source: 'api',
    );
  }

  factory Category.fromFirebase(Map<String, dynamic> data) {
    return Category(
      id: data['id'],
      name: data['name'] ?? "Unknown Category",
      source: 'firebase',
    );
  }
}
