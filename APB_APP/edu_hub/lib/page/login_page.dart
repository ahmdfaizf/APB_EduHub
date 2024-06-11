import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_hub/components/my_button.dart';
import 'package:edu_hub/components/my_textfield.dart';
import 'package:edu_hub/constant/colors.dart';
import 'package:edu_hub/helper/helper_function.dart';
import 'package:edu_hub/page/main_page.dart';
import 'package:edu_hub/page/main_teacher_page.dart';
import 'package:edu_hub/page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign in method
  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Sign in with email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        // Get user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('userCredential')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // Get user role
          String role = userDoc['role'];
          // Remove the loading indicator
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          
          // Navigate to the corresponding page based on user role
          if (role == 'Teacher') {
            Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => const MainTeacherPage()),
            );
          } else {
            Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          }
        } else {
          // Remove the loading indicator
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // If user data is not found
          // ignore: use_build_context_synchronously
          displayMessageToUser('User data not found', context);
        }
      }
    } on FirebaseAuthException catch (e) {
      // Remove the loading indicator
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // Display error message to the user
      // ignore: use_build_context_synchronously
      displayMessageToUser(e.message ?? 'An error occurred', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            AppPalet.primary,
            Color.fromARGB(193, 99, 171, 207)
          ])),
          child: Column(
            children: <Widget>[
              // Logo
              Image.asset(
                "assets/LogoEduHub.png",
                height: 250,
              ),

              // Welcome text
              const Text('Welcome to EduHub',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 20)),

              const SizedBox(
                height: 25,
              ),

              // Username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(
                height: 15,
              ),

              // Password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(
                height: 10,
              ),

              // Forgot password?
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot your password?'),
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // Sign in button
              MyButton(
                onTap: signUserIn,
                namaButton: "Log In",
              ),

              const SizedBox(
                height: 50,
              ),

              // Sign up
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('or Sign Up here'),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
