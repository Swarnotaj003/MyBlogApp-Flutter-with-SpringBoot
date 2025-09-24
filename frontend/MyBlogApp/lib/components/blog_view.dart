import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_blog_app/model/blog_post.dart';
import 'package:my_blog_app/service/blog_post_provider.dart';
import 'package:my_blog_app/util/date_time_formatter.dart';
import 'package:provider/provider.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key, required this.blogPostId});

  final int blogPostId;

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  // The post to be displayed
  late int blogPostId;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    blogPostId = widget.blogPostId;

    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      final BlogPost? blogPost = Provider.of<BlogPostProvider>(context, listen: false)
          .getBlogPostById(blogPostId);

      if (blogPost == null || blogPost.images.length <= 1) {
        return;
      }

      if (_currentPage < blogPost.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogPostProvider>(
      builder: (context, value, widget) {
        // Get the updated blog post from provider by id
        final blogPost = value.getBlogPostById(blogPostId);
        if (blogPost == null) {
          return Center(child: Text('Post not found'));
        }

        // Post likes
        final isLiked = value.isLiked(blogPost.id);
        final likeCount = blogPost.likedBy.length;

        return Scaffold(
          backgroundColor: Colors.grey[200],

          body: Column(
            children: [
              // Blog poster
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    // Background image
                    Positioned.fill(
                      child: blogPost.images.isEmpty || blogPost.images[0].isEmpty
                          ? Icon(Icons.image, color: Colors.white, size: 48)
                          : PageView.builder(
                              controller: _pageController,
                              physics: NeverScrollableScrollPhysics(), // disables manual scroll
                              itemCount: blogPost.images.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  blogPost.images[index],
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter,
                                );
                              },
                            ),
                    ),

                    // Blackish film
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    // Blog header
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Back button
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            // Blog title
                            Text(
                              blogPost.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Blog tag
                            Card(
                              color: Colors.white54,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 8,
                                ),
                                child: Text(
                                  blogPost.tag.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Blog content
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Author image
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.brown[200],
                          foregroundImage: NetworkImage(
                            blogPost.author.profilePicture,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.brown,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Author name
                            Text(
                              blogPost.author.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Posted on
                            Text(
                              'Posted on: ${getDate(blogPost.createdAt)}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Last updated
                            Text(
                              'Last updated: ${getDate(blogPost.updatedAt)}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                        // Like this post
                        TextButton.icon(
                          onPressed: () {
                            isLiked ? value.unlikeBlogPost(blogPostId): value.likeBlogPost(blogPostId);                  
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: isLiked ? Colors.red[100] : Colors.transparent,
                          ),
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_outline,
                            color: isLiked ? Colors.red : Colors.black,
                            size: 24,
                          ),
                          label: Text(
                            likeCount.toString(),
                            style: TextStyle(
                              color: isLiked ? Colors.red : Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),  
                      ],
                    ),

                    Divider(color: Colors.grey, height: 30),

                    // Actual content
                    Text(
                      blogPost.content,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),              
            ],
          ),
        );
      },
    );
  }
}
