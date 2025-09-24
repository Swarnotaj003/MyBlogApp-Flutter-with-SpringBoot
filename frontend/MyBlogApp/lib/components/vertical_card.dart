import 'package:flutter/material.dart';
import 'package:my_blog_app/components/blog_view.dart';
import 'package:my_blog_app/model/blog_post.dart';
import 'package:my_blog_app/util/date_time_formatter.dart';

class VerticalCard extends StatelessWidget {
  const VerticalCard({
    super.key,
    required this.blogPost,
  });

  final BlogPost blogPost;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogView(blogPostId: blogPost.id),
          ),
        );
      },

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 240,
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          child: Column(
            children: [
              // Image
              Expanded(
                flex: 3,
                child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: blogPost.images.isNotEmpty && blogPost.images[0].isNotEmpty
                    ? Image.network(
                        blogPost.images[0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(
                        color: Colors.grey,
                        child: Icon(Icons.image, color: Colors.grey[100]),
                      ),
                ),
              ),
      
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      SizedBox(
                        height: 45,
                        child: Text(
                          blogPost.title,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,                      
                        ),
                      ),
        
                      // Content
                      // Text(
                      //   blogPost.content,
                      //   style: TextStyle(fontSize: 12),
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 3,
                      // ),
                      // SizedBox(height: 10,),
                      
                      Row(
                        children: [
                          // Blog tag
                          Card(
                            color: Colors.brown,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: 8,
                              ),
                              child: Text(
                                blogPost.tag.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
      
                          // Likes count
                          Icon(Icons.favorite, color: Colors.grey, size: 20),
                          SizedBox(width: 5),
                          Text(
                            blogPost.likedBy.length.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),                   
        
                      // Author
                      Row(
                        children: [
                          // Author image
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.brown[200],
                            foregroundImage: NetworkImage(
                              blogPost.author.profilePicture,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(width: 10),
        
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Author name
                                Text(
                                  blogPost.author.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),                              
                                // Posted on
                                Text(
                                  'Posted on: ${getDate(blogPost.createdAt)}',
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // Last updated
                                // Text(
                                //   'Last updated: ${getDate(blogPost.updatedAt)}',
                                //   style: TextStyle(color: Colors.black, fontSize: 12),
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                              ],
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
      ),
    );
  }
}