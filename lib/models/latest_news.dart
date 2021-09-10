class LatestNewsModel {
  final String title;
  final String desc;
  final String published_date;
  final String multimedia;

  LatestNewsModel({
    required this.title,
    required this.desc,
    required this.published_date,
    required this.multimedia,
  });

  factory LatestNewsModel.fromJson(Map<String, dynamic> json) {
    return LatestNewsModel(
      title: json['title'] as String,
      desc: json['abstract'] as String,
      published_date: json['published_date'] as String,
      multimedia:
          (json['multimedia'] != null && json['multimedia'][3]['url'] != null)
              ? json['multimedia'][3]['url'] as String
              : 'https://www.asrar-co.com/image/cache/placeholder-300x300.png',
    );
  }
}
