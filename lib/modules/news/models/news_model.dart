class ListNewsModel {
  List<NewsModel>? listNews;

  ListNewsModel({this.listNews});

  ListNewsModel.fromJson(Map<String, dynamic> json) {
    listNews = json["listNews"] == null ? null : (json["listNews"] as List).map((e) => NewsModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(listNews != null) {
      _data["listNews"] = listNews?.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  ListNewsModel copyWith({
    List<NewsModel>? listNews,
  }) => ListNewsModel(
    listNews: listNews ?? this.listNews,
  );
}

class NewsModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  NewsModel({this.userId, this.id, this.title, this.body});

  NewsModel.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
    body = json["body"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["id"] = id;
    data["title"] = title;
    data["body"] = body;
    return data;
  }

  NewsModel copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) => NewsModel(
    userId: userId ?? this.userId,
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
  );
}