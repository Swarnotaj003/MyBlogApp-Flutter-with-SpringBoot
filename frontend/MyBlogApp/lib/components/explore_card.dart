import 'package:flutter/material.dart';
import 'package:my_blog_app/components/blog_view.dart';
import 'package:my_blog_app/model/blog_post.dart';
import 'package:my_blog_app/service/blog_post_provider.dart';
import 'package:my_blog_app/util/date_time_formatter.dart';
import 'package:provider/provider.dart';

class ExploreCard extends StatefulWidget {
  const ExploreCard({super.key, required this.blogPost});

  final BlogPost blogPost;

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BlogPostProvider>(      
      builder: (context, value, child) {
        final isLiked = value.isLiked(widget.blogPost.id);
        final likesCount = widget.blogPost.likedBy.length;

        return GestureDetector(
          // redirect to blog view on tap
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlogView(blogPostId: widget.blogPost.id),
              ),
            );
          },

          // Actual card
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child:
                      widget.blogPost.images.isEmpty || widget.blogPost.images[0].isEmpty
                          ? Icon(Icons.image, color: Colors.grey[300], size: 32)
                          : Image.network(
                            widget.blogPost.images[0],
                            fit: BoxFit.cover,
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

                // Foreground text
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Post title
                        Text(
                          widget.blogPost.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            // Author profile picture
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.brown[200],
                              foregroundImage: NetworkImage(
                                widget.blogPost.author.profilePicture,
                              ),
                              child: Icon(Icons.person, color: Colors.brown),
                            ),
                            SizedBox(width: 5),
                            // Author name
                            Text(
                              widget.blogPost.author.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            // Post added date
                            Text(
                              getDate(widget.blogPost.createdAt),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(child: SizedBox()),
                            // Likes count
                            Icon(
                              isLiked ? Icons.favorite : Icons.favorite_outline, 
                              color: isLiked ? Colors.red : Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              likesCount.toString(),
                              style: TextStyle(
                                color: isLiked ? Colors.red : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
