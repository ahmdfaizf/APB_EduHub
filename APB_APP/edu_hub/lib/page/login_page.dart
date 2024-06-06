import 'package:edu_hub/components/my_button.dart';
import 'package:edu_hub/components/my_textfield.dart';
import 'package:edu_hub/constant/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method (masih kosong karena baru UI)
  void signUserIn(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppPalet.primary, Color.fromARGB(193, 99, 171, 207)])),
                child: Column(
                  children: <Widget>[
                    // logo
                    Image.asset("assets/LogoEduHub.png",height: 250,),

                    // welcome text
                    const Text('Welcome to EduHub',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20)),

                    const SizedBox(height: 25,),

                    // uname textfield
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                    ),

                    const SizedBox(height: 15,),

                    // password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 10,),

                    // forgot password?
                    const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Forgot your password?'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25,),

                    // sign in button
                    MyButton(
                      onTap: signUserIn,
                    ),

                    const SizedBox(height: 50,),

                    // Sign up
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: 
                            Divider(
                            thickness: 0.5,
                            color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('or Sign Up here'),
                          ),
                          Expanded(
                            child: 
                            Divider(
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