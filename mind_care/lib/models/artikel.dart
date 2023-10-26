class Article {
  final int id;
  final String title;
  final String description;

  Article({required this.id, required this.title, required this.description});
  static fromJson(data) {}
}
