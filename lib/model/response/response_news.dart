import '../news.dart';

class ResponseNews {
  String? timestamp;
  int? code;
  String? status;
  String? message;
  ResNews? data;

  ResponseNews(
      {this.timestamp, this.code, this.status, this.message, this.data});

  ResponseNews.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ResNews.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResNews {
  List<News>? news;
  int? total;
  String? perPage;
  int? currentPage;
  String? nextPageUrl;
  dynamic previousPageUrl;

  ResNews(
      {this.news,
      this.total,
      this.perPage,
      this.currentPage,
      this.nextPageUrl,
      this.previousPageUrl});

  ResNews.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    nextPageUrl = json['next_page_url'];
    previousPageUrl = json['previous_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['next_page_url'] = nextPageUrl;
    data['previous_page_url'] = previousPageUrl;
    return data;
  }
}
