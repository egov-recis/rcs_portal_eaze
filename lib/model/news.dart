class New {
  List<News>? news;

  New({this.news});

  New.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? title;
  String? content;
  String? image;
  String? publishedDate;

  News({this.title, this.content, this.image, this.publishedDate});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
    publishedDate = json['published_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['published_date'] = publishedDate;
    return data;
  }
}
