class NewsModel {
  final String title;
  final String? imageUrl;
  final String articleUrl;
  NewsModel({
    required this.title,
    this.imageUrl,
    required this.articleUrl,
  });
}
