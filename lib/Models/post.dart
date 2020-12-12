class Post {
  final String id;
  final String imageUrl;
  final String caption;
  final int likeCount;
  final String authorId;

  Post({this.id, this.imageUrl, this.caption, this.likeCount, this.authorId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["_id"],
      imageUrl: json['imageUrl'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      authorId: json['authorId'],
    );
  }
}
