import 'package:flutter/material.dart';
import 'package:my_blog_app/model/user.dart';

class UserProvider extends ChangeNotifier {
  // Simulated user database
  final Map<String, User> _userDB = {
    'john@example.com': User(
      id: 1, name: 'John Doe', email: 'john@example.com', password: 'password123',
      bio: 'Tech enthusiast and blogger.',
      profilePicture: 'https://plus.unsplash.com/premium_photo-1739178656495-8109a8bc4f53?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    'jane@example.com': User(
      id: 2, name: 'Jane Smith', email: 'jane@example.com', password: 'password456',
      bio: 'Businessman, avid traveler and food lover.',
      profilePicture: 'https://plus.unsplash.com/premium_photo-1739786995646-480d5cfd83dc?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    'alice@example.com': User(
      id: 3, name: 'Alice Johnson', email: 'alice@example.com', password: 'password789',
      bio: 'Passion for Fashion. Photographer and nature lover.',
      profilePicture: 'https://plus.unsplash.com/premium_photo-1739786995552-0a2ccfa62ba5?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  };

  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  bool get isLoggedIn => _loggedInUser != null;

  User getUserByEmail(String email) {
    return _userDB[email]!;
  }

  bool signUp(User user) {
    if (_userDB.containsKey(user.email)) {
      return false; 
    } 
    _userDB[user.email] = user;
    _loggedInUser = user;
    notifyListeners();
    return true;
  }

  bool login(String email, String password) {
    if (_userDB.containsKey(email) && _userDB[email]!.password == password) {
      _loggedInUser = _userDB[email];
      notifyListeners();
      return true;
    } 
    return false;
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }
  
  void updateProfile(String name, String bio, String profilePicture) {
    if (_loggedInUser != null) {
      _loggedInUser = User(
        id: _loggedInUser!.id,
        name: name,
        email: _loggedInUser!.email,
        password: _loggedInUser!.password,
        bio: bio,
        profilePicture: profilePicture,
      );
      _userDB[_loggedInUser!.email] = _loggedInUser!;
      notifyListeners();
    }
  }
  
}