import 'package:my_blog_app/model/user.dart';

class BlogPost {
  final int id;
  String title;
  String content;
  String tag;
  final User author;
  final DateTime createdAt;
  DateTime updatedAt;
  List<String> images;
  List<User> likedBy;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.tag,
    required this.author, 
    required this.createdAt,
    required this.updatedAt, 
    this.images = const [],
    this.likedBy = const [],
  });
}