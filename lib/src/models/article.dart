class Article {
  final int id;
  final String title;
  final String desc;
  final String thumbnail;
  final String url;
  final bool isTrending;
  final DateTime createdAt;

  Article({
    required this.id,
    required this.title,
    required this.desc,
    required this.thumbnail,
    required this.url,
    required this.isTrending,
    required this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String,
      desc: json['desc'] as String,
      thumbnail: json['thumbnail'] as String,
      url: json['url'] as String,
      isTrending: (json['is_trending'] as bool?) ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
