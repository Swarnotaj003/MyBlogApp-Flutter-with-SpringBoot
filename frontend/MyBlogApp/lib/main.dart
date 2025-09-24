import 'package:flutter/material.dart';
import 'package:my_blog_app/screens/authenticate/auth_wrapper.dart';
import 'package:my_blog_app/screens/home/home_wrapper.dart';
import 'package:my_blog_app/service/blog_post_provider.dart';
import 'package:my_blog_app/service/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProxyProvider<UserProvider, BlogPostProvider>(
          create: (context) => BlogPostProvider(userProvider: context.read<UserProvider>()),
          update: (context, userProvider, blogPostProvider) =>
            BlogPostProvider(userProvider: userProvider),
        ),
      ], 
      child: const MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider> (
      builder: (context, value, child) {
        return MaterialApp(
          title: 'My Blog App',
          debugShowCheckedModeBanner: false,
          home: value.isLoggedIn ? HomeWrapper() : AuthWrapper(),
        );
      } 
    );
  }
}