class DataModel {
  List? post;
  int? total;
  int? skip;
  int? limit;
  PostModel? postModel;

  DataModel({this.post, this.total, this.skip, this.limit, this.postModel});

  factory DataModel.fromJson(Map json){
    return DataModel(
      post: json['post'],
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
      postModel: PostModel.fromJson(json['postModel']),
    );
  }
}

class PostModel{
  int? id;
  String? title;
  String? body;
  List? tags;
  int? views;
  int? userId;
  Reactions? reactions;

  PostModel({this.userId, this.views, this.body, this.title, this.id, this.tags, this.reactions});

  factory PostModel.fromJson(Map json){
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      tags: json['tags'],
      views: json['views'],
      userId: json['userId'],
      reactions: Reactions.fromJson(json['reaction']),
    );
  }
}

class Reactions{
  int? likes;
  int? dislikes;

  Reactions({this.dislikes, this.likes});

  factory Reactions.fromJson(Map json){
    return Reactions(
      likes: json['likes'],
      dislikes: json['dislikes'],
    );
  }

}