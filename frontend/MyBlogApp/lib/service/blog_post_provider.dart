import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_blog_app/model/blog_post.dart';
import 'package:my_blog_app/model/user.dart';
import 'package:my_blog_app/service/user_provider.dart';

class BlogPostProvider extends ChangeNotifier {
  // User service
  final UserProvider userProvider;

  BlogPostProvider({
    required this.userProvider
  });

  // Blog post categories
  final List<String> _tags = ['Technology', 'Travel', 'Business', 'Fashion'];

  // Simulated blog post database
  late final List<BlogPost> _blogPostDB = [
    // ---------------- Technology ----------------
    BlogPost(
      id: 1,
      title: 'Understanding Flutter Widgets',
      content: 'Flutter widgets are the building blocks of every Flutter app. '
          'They describe what their view should look like given their current configuration and state. '
          'By composing widgets, developers can build complex UIs in a declarative way, making development faster and more predictable.',
      tag: 'Technology',
      author: userProvider.getUserByEmail('john@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1617040619263-41c5a9ca7521?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),
    BlogPost(
      id: 2,
      title: 'The Future of AI in Mobile Apps',
      content: 'Artificial Intelligence is revolutionizing mobile apps, from chatbots to image recognition. '
          'With frameworks like TensorFlow Lite, AI can run directly on devices, providing faster and more secure experiences. '
          'Developers need to explore ways to integrate AI responsibly to enhance user engagement.',
      tag: 'Technology',
      author: userProvider.getUserByEmail('john@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1746286720984-72f386e1872e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),
    BlogPost(
      id: 3,
      title: 'Why Cybersecurity Matters More Than Ever',
      content: 'In today’s digital age, data breaches are common and can cost companies millions. '
          'Cybersecurity measures such as multi-factor authentication, encryption, and secure coding practices are critical. '
          'Developers must adopt a security-first mindset to protect both businesses and users.',
      tag: 'Technology',
      author: userProvider.getUserByEmail('john@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1585900463446-6feaef274557?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),

    // ---------------- Travel ----------------
    BlogPost(
      id: 4,
      title: 'Backpacking Across Europe',
      content: 'Backpacking is one of the best ways to experience Europe. '
          'From historic castles in Germany to the artistic streets of Paris, every city has its own charm. '
          'Traveling light, staying in hostels, and using local transport keeps the journey affordable and adventurous.',
      tag: 'Travel',
      author: userProvider.getUserByEmail('jane@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1557066911-9184d3f95959?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),
    BlogPost(
      id: 5,
      title: 'Top 5 Beaches in Southeast Asia',
      content: 'Southeast Asia is home to some of the world’s most beautiful beaches. '
          'From the crystal-clear waters of Boracay in the Philippines to the serene shores of Bali, '
          'these destinations offer relaxation, adventure, and breathtaking views. Perfect for any travel enthusiast.',
      tag: 'Travel',
      author: userProvider.getUserByEmail('alice@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1520483725102-a4daafec9a73?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),
    BlogPost(
      id: 6,
      title: 'Why Solo Travel Changes You',
      content: 'Traveling alone teaches resilience, independence, and confidence. '
          'It allows you to make spontaneous decisions, meet new people, and truly discover yourself. '
          'Solo journeys are often transformative and create lifelong memories that shape your worldview.',
      tag: 'Travel',
      author: userProvider.getUserByEmail('jane@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1605274280779-a4732e176f4b?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),

    // ---------------- Business ----------------
    BlogPost(
      id: 7,
      title: 'The Rise of Remote Work',
      content: 'Remote work has shifted from being a temporary solution to a permanent trend. '
          'Companies are embracing flexible work models, cutting costs, and giving employees better work-life balance. '
          'This change requires better digital infrastructure and management practices for long-term success.',
      tag: 'Business',
      author: userProvider.getUserByEmail('jane@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now(),
      images: [
        ''
      ],
    ),
    BlogPost(
      id: 8,
      title: 'Why Startups Fail',
      content: 'Many startups fail due to poor market research, lack of funding, or scaling too fast. '
          'Successful entrepreneurs focus on solving real problems, listening to customer feedback, '
          'and building strong, adaptable teams. Sustainability is key to survival in a competitive market.',
      tag: 'Business',
      author: userProvider.getUserByEmail('jane@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now(),
      images: [
        'https://plus.unsplash.com/premium_photo-1694743671394-60034a1b2f65?q=80&w=1228&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),
    BlogPost(
      id: 9,
      title: 'The Power of Networking',
      content: 'Networking is essential for business growth. '
          'Building meaningful connections opens doors to opportunities, mentorship, and collaborations. '
          'In today’s interconnected world, relationships often matter as much as skills or capital in driving success.',
      tag: 'Business',
      author: userProvider.getUserByEmail('jane@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1675716921224-e087a0cca69a?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),

    // ---------------- Fashion ----------------
    BlogPost(
      id: 10,
      title: 'Sustainable Fashion: The Future of Style',
      content: 'Fast fashion has long dominated the industry, but its environmental impact is devastating. '
          'Sustainable fashion focuses on eco-friendly materials, ethical production, and conscious consumer choices. '
          'The future of fashion lies in quality over quantity, and timeless designs over trends.',
      tag: 'Fashion',
      author: userProvider.getUserByEmail('alice@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now(),
      images: [
        'https://plus.unsplash.com/premium_photo-1713586580695-4561ceb1e80c?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),
    BlogPost(
      id: 11,
      title: 'Top Fashion Trends in 2025',
      content: 'Fashion in 2025 is all about blending comfort with elegance. '
          'Oversized fits, earthy tones, and tech-integrated clothing dominate runways. '
          'The modern wardrobe is practical yet stylish, reflecting the fast-changing lifestyle of younger generations.',
      tag: 'Fashion',
      author: userProvider.getUserByEmail('alice@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ],
    ),
    BlogPost(
      id: 12,
      title: 'Minimalist Wardrobe Essentials',
      content: 'A minimalist wardrobe saves time, money, and mental energy. '
          'Focusing on high-quality basics like plain tees, classic jeans, and versatile shoes, '
          'you can create endless outfit combinations. Minimalism is not just a trend—it’s a lifestyle choice.',
      tag: 'Fashion',
      author: userProvider.getUserByEmail('alice@example.com'),
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1547227818-2d544e6ec56b?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ],
    ),
  ];

  List<String> get tags => _tags;

  List<BlogPost> get blogPosts => _blogPostDB;

  // Methods to fetch Blog Posts

  BlogPost? getBlogPostById(int id) {
    try {
      return _blogPostDB.firstWhere((post) => post.id == id);
    } catch (e) {
      return null;
    }
  }

  List<BlogPost> getBlogPostByTag(String tag) {
    List<BlogPost> blogPostByTag = [];
    for (BlogPost post in _blogPostDB) {
      if (post.tag.toLowerCase() == tag.toLowerCase()) {
        blogPostByTag.add(post);
      }
    }
    return blogPostByTag;
  }

  // Methods for like functionality

  bool isLiked(int blogId) {
    BlogPost? blogPost = getBlogPostById(blogId);
    User? currUser = userProvider.loggedInUser;
    if (currUser == null || blogPost == null) {
      return false;
    } 
    return blogPost.likedBy.any((liker) => liker.id == currUser.id);
  }

  void likeBlogPost(int blogId) {
    final index = _blogPostDB.indexWhere((post) => post.id == blogId);
    if (index == -1) {
      return;
    }

    final blogPost = _blogPostDB[index];
    final currUser = userProvider.loggedInUser;

    if (currUser == null || isLiked(blogId)) {
      return;
    }

    // Add current user to likedBy
    final updatedLikedBy = List<User>.from(blogPost.likedBy)..add(currUser);

    // Update the blog post immutably
    final updatedPost = BlogPost(
      id: blogPost.id,
      title: blogPost.title,
      content: blogPost.content,
      author: blogPost.author,
      createdAt: blogPost.createdAt,
      updatedAt: blogPost.updatedAt,
      tag: blogPost.tag,
      images: blogPost.images,
      likedBy: updatedLikedBy,
    );

    // Replace the old post in the DB
    _blogPostDB[index] = updatedPost;
    notifyListeners();
  }

  void unlikeBlogPost(int blogId) {
    final index = _blogPostDB.indexWhere((post) => post.id == blogId);
    if (index == -1) {
      return;
    }

    final blogPost = _blogPostDB[index];
    final currUser = userProvider.loggedInUser;

    if (currUser == null || !isLiked(blogId)) {
      return;
    }

    // Remove current user from likedBy
    final updatedLikedBy = List<User>.from(blogPost.likedBy)
      ..removeWhere((user) => user.id == currUser.id);

    // Update the blog post immutably
    final updatedPost = BlogPost(
      id: blogPost.id,
      title: blogPost.title,
      content: blogPost.content,
      author: blogPost.author,
      createdAt: blogPost.createdAt,
      updatedAt: blogPost.updatedAt,
      tag: blogPost.tag,
      images: blogPost.images,
      likedBy: updatedLikedBy,
    );

    // Replace the old post in the DB
    _blogPostDB[index] = updatedPost;
    notifyListeners();
  }

  // Method to post a new blog
  void addBlog(String title, String content, String tag, List<String> images) {
    User? author = userProvider.loggedInUser;

    // terminate if no user is logged in
    if (author == null) {
      return;
    }

    // create a new blogPost object
    BlogPost blogPost = BlogPost(
      id: _blogPostDB.length + 1,
      title: title,
      content: content,
      tag: tag,
      author: author,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      images: images,
    );

    // save it to the DB
    _blogPostDB.add(blogPost);
    notifyListeners();
  }

  // Methods to fetch posts related to the current user

  List<BlogPost> getBlogsPostedByUser() {
    User? author = userProvider.loggedInUser;
    return author == null ? [] : _blogPostDB.where(
      (blog) => blog.author.id == author.id
    ).toList();
  }

  List<BlogPost> getBlogsLikedByUser() {
    User? liker = userProvider.loggedInUser;
    return liker == null ? [] : _blogPostDB.where(
      (blog) => blog.likedBy.any(
        (user) => user.id == liker.id
      )
    ).toList();
  }
  
  // Fetch n most trending posts
  List<BlogPost> getMostLikedPosts(int n) {
    PriorityQueue<BlogPost> minHeap = PriorityQueue(
      (a, b) {
        int aLikes = a.likedBy.length;
        int bLikes = b.likedBy.length;
        return aLikes.compareTo(bLikes);
      }
    );

    for (BlogPost blogPost in _blogPostDB) {
      if (minHeap.length == n) {
        minHeap.removeFirst();
      }
      minHeap.add(blogPost);
    }

    List<BlogPost> topLikedPosts = [];
    while (minHeap.isNotEmpty) {
      topLikedPosts.add(minHeap.removeFirst());
    }
    return topLikedPosts.reversed.toList();
  }
  
  // Fetch n most recent posts
  List<BlogPost> getMostRecentPosts(int n) {
    return _blogPostDB
      .sublist(_blogPostDB.length - n < 0 ? 0 : _blogPostDB.length - n)
      .reversed.toList();
  }
  
}