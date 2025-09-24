import 'package:flutter/material.dart';
import 'package:my_blog_app/components/my_snack_bar.dart';
import 'package:my_blog_app/screens/home/home.dart';
import 'package:my_blog_app/screens/home/add_post.dart';
import 'package:my_blog_app/screens/home/explore.dart';
import 'package:my_blog_app/screens/home/profile.dart';
import 'package:my_blog_app/service/user_provider.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int navBarIndex = 0;

  List<String> titles = [
    'Home', 'Explore', 'Add Post', 'Profile'
  ];

  List<Widget> screens = [
    Home(), Explore(), AddPost(), Profile()
  ];

  void onNavBarTap(int index) {
    setState(() {
      navBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[navBarIndex]),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.grey[200],
        actions: [
          // Logout button
          IconButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).logout();
              showMySnackBar(context, 'You were logged out!', Colors.red);
            },
            icon: Icon(Icons.logout),
            color: Colors.brown,
            iconSize: 28,
          )
        ],
      ),
    
      body: Center(
        child: screens[navBarIndex],
      ),
    
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavBarTap,
        currentIndex: navBarIndex,
      
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        iconSize: 30,
      
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_photos_outlined),
            activeIcon: Icon(Icons.add_to_photos),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )
    
    );
  }
}