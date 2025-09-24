import 'package:flutter/material.dart';
import 'package:my_blog_app/components/my_snack_bar.dart';
import 'package:my_blog_app/service/user_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function onTap;

  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Text controllers
  final TextEditingController _emailController = TextEditingController();  
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
          
                Text(
                  'Continue surfing into blogging world',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
          
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
                      'images/login_poster.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
          
                // Login Form
                Text(
                  'Login to continue',
                  style: TextStyle(
                    fontSize: 16,
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
                
                // Login Button
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  onPressed: () {
                    // Empty text validation
                    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {  
                      showMySnackBar(context, 'Please fill all the fields!', Colors.red);
                      return;
                    }
                    // Email format validation
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
                      showMySnackBar(context, 'Please enter a valid email!', Colors.red);
                      return;
                    }
          
                    // Login action                  
                    bool success = Provider.of<UserProvider>(context, listen: false).login(_emailController.text.trim(), _passwordController.text);
                    if (success) {
                      showMySnackBar(context, 'Logged in successfully!', Colors.green);
                    } else {
                      showMySnackBar(context, 'Invalid credentials!', Colors.red);
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(height: 10,),
                
                // Switch to Sign Up
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  onPressed: () {
                    widget.onTap();
                  },
                  child: Text(
                    'Sign Up',
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