import 'package:flutter/material.dart';
import 'package:my_blog_app/components/explore_card.dart';
import 'package:my_blog_app/model/blog_post.dart';
import 'package:my_blog_app/service/blog_post_provider.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // Selected category
  String selectedCategory = 'All';

  // Blog post categories
  List<String> categories = ['All'];

  // Blog posts
  List<BlogPost> blogPosts = [];

  @override
  void initState() {
    // fetch initial data
    final provider = Provider.of<BlogPostProvider>(context, listen: false);
    blogPosts = provider.blogPosts;
    categories.addAll(provider.tags);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogPostProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.grey[200],

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // Categories
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      // selection control
                      String category = categories[index];
                      bool isSelected = category == selectedCategory;

                      return GestureDetector(
                        onTap: () {
                          // select category action
                          setState(() {
                            selectedCategory = category;
                            if (category == 'All') {
                              blogPosts = value.blogPosts;
                            } else {
                              blogPosts = value.getBlogPostByTag(category);
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.brown : Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.brown),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.brown,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),

                // Explore Grid
                Expanded(
                  child: blogPosts.isEmpty
                  ? Center(
                      child: Text('Nothing to show yet. Please visit later.'),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: blogPosts.length,
                      itemBuilder: (context, index) {
                        return ExploreCard(blogPost: blogPosts[index]);
                      },
                    ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
