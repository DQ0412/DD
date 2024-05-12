class Vocabulary {
  final String id;
  final String word;
  String definition;
  int learnedCount;
  int memorizedCount;
  int totalCount;
  String status;

  Vocabulary({
    required this.id,
    required this.word,
    this.definition = '',
    this.learnedCount = 0,
    this.memorizedCount = 0,
    this.totalCount = 0,
    this.status = 'unlearned',
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      id: json['id'],
      word: json['word'],
      definition: json['definition'],
      learnedCount: json['learnedCount'],
      memorizedCount: json['memorizedCount'],
      totalCount: json['totalCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'definition': definition,
      'learnedCount': learnedCount,
      'memorizedCount': memorizedCount,
      'totalCount': totalCount,
    };
  }
}
