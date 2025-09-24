import 'package:flutter/material.dart';
import 'package:my_blog_app/components/horizontal_card.dart';
import 'package:my_blog_app/components/vertical_card.dart';
import 'package:my_blog_app/model/blog_post.dart';
import 'package:my_blog_app/service/blog_post_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BlogPostProvider>(
      builder: (context, value, child) {
        // Most recent posts
        List<BlogPost> recentPosts = value.getMostRecentPosts(5);

        // Most popular posts
        List<BlogPost> popularPosts = value.getMostLikedPosts(5);

        return Scaffold(
          backgroundColor: Colors.grey[200],

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
                  // Trending Now
                  Text(
                    'Trending Now',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: popularPosts.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return VerticalCard(blogPost: popularPosts[index],);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
              
                  // Recent Posts
                  Text(
                    'Recent Posts',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    itemCount: recentPosts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HorizontalCard(blogPost: recentPosts[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
