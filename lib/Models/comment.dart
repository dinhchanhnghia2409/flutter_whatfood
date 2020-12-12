class Comment {
  final String id;
  final String content;
  final String authorId;
  final DateTime time;

  Comment({this.id, this.content, this.authorId, this.time});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      authorId: json['authorId'],
      time: json['time'],
    );
  }
}
