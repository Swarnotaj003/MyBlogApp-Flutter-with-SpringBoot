import 'package:my_blog_app/model/blog_post.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  String bio;
  String profilePicture;
  List<BlogPost> likedPosts;
  List<BlogPost> userPosts;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.bio = '',
    this.profilePicture = '',
    this.likedPosts = const [],
    this.userPosts = const []
  });
}