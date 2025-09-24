import 'package:flutter/material.dart';
import 'package:my_blog_app/components/edit_profile_form.dart';
import 'package:my_blog_app/components/horizontal_card.dart';
import 'package:my_blog_app/model/blog_post.dart';
import 'package:my_blog_app/model/user.dart';
import 'package:my_blog_app/service/blog_post_provider.dart';
import 'package:my_blog_app/service/user_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Section control
  int sectionId = 0;
  List<String> sectionHeaders = ['My Posts', 'Liked Posts'];

  // Edit profile function
  void editProfile(String name, String bio, String profilePicture) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => EditProfileForm(
            name: name,
            bio: bio,
            profilePicture: profilePicture,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        // Current user
        User loggedInUser = value.loggedInUser!;

        return Consumer<BlogPostProvider>(
          builder: (context, value, child) {
            // Sections lists
            List<BlogPost> postedBlogs = value.getBlogsPostedByUser();
            List<BlogPost> likedBlogs = value.getBlogsLikedByUser();
            List<List<BlogPost>> sectionBodies = [postedBlogs, likedBlogs];

            return Scaffold(
              backgroundColor: Colors.grey[200],

              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.brown,
                          child: CircleAvatar(
                            radius: 77.5,
                            backgroundColor: Colors.grey[200],
                            child: CircleAvatar(
                              radius: 75,
                              backgroundColor: Colors.brown[100],
                              foregroundImage: NetworkImage(
                                loggedInUser.profilePicture,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 150,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // User Name
                      Text(
                        loggedInUser.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),

                      // Email
                      Text(
                        loggedInUser.email,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Bio
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Bio',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          loggedInUser.bio.isNotEmpty
                              ? loggedInUser.bio
                              : 'Add bio to let others know about you.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Edit Profile Button
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          editProfile(
                            loggedInUser.name,
                            loggedInUser.bio,
                            loggedInUser.profilePicture,
                          );
                        },
                        label: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        icon: Icon(Icons.edit, color: Colors.brown, size: 24),
                      ),
                      SizedBox(height: 10),

                      // User Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // My Posts count
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sectionId = 0;
                                });
                              },
                              child: Card(
                                color:
                                    sectionId == 0
                                        ? Colors.brown
                                        : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        sectionBodies[0].length.toString(),
                                        style: TextStyle(
                                          color:
                                              sectionId == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'My Posts',
                                        style: TextStyle(
                                          color:
                                              sectionId == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Liked posts count
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sectionId = 1;
                                });
                              },
                              child: Card(
                                color:
                                    sectionId == 1
                                        ? Colors.brown
                                        : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        sectionBodies[1].length.toString(),
                                        style: TextStyle(
                                          color:
                                              sectionId == 1
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Liked posts',
                                        style: TextStyle(
                                          color:
                                              sectionId == 1
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // My Posts or Liked Posts Section
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          sectionHeaders[sectionId],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      ListView.builder(
                        itemCount: sectionBodies[sectionId].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return HorizontalCard(blogPost: sectionBodies[sectionId][index],);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
