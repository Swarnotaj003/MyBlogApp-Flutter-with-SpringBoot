import 'package:flutter/material.dart';
import 'package:my_blog_app/components/my_snack_bar.dart';
import 'package:my_blog_app/model/user.dart';
import 'package:my_blog_app/service/user_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function onTap;

  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();  
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
          
              children: [
                // Header
                Text(
                  'Hey Blogger!',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
          
                Text(
                  'Get started with your free account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
          
                // Avatar image
                SizedBox(
                  height: 200,
                  child: Card(
                    color: Colors.grey[300],
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset(
                      'images/signup_poster.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
          
                // Sign Up Form
                Text(
                  'Sign-up to continue',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                          
                // Username Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    controller: _nameController,
                  ),
                ),
                SizedBox(height: 10),
                
                // Email Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email ID',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    controller: _emailController,
                  ),
                ),
                SizedBox(height: 10),
                
                // Password Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                  ),
                ),
                SizedBox(height: 20),
                
                // Sign Up Button
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  onPressed: () {
                    // Empty text validation
                    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
                      showMySnackBar(context, 'Please fill all the fields!', Colors.red);
                      return;
                    }

                    // Email format validation
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
                      showMySnackBar(context, 'Please enter a valid email!', Colors.red);
                      return;
                    }

                    // Password length validation
                    if (_passwordController.text.length < 6) {
                      showMySnackBar(context, 'Password must be at least 6 characters!', Colors.red);
                      return;
                    }

                    // Sign Up action
                    User user = User(
                      id: 0,
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text,
                    );
                    bool success = Provider.of<UserProvider>(context, listen: false).signUp(user);
                    if (success) {
                      showMySnackBar(context, 'Account created successfully!', Colors.green);
                    } else {
                      showMySnackBar(context, 'User already exists!', Colors.red);
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                
                // Switch to Login
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  onPressed: () {
                    widget.onTap();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.brown, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}