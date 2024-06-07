import 'package:edu_hub/components/my_button.dart';
import 'package:edu_hub/components/my_textfield.dart';
import 'package:edu_hub/constant/colors.dart';
import 'package:edu_hub/page/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String? selectedRole;

  void registerUser() {
    // Kosong karena baru ui
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
                colors: [AppPalet.primary, Color.fromARGB(193, 99, 171, 207)]),
          ),
          child: Column(
            children: <Widget>[
              Image.asset(
                "assets/LogoEduHub.png",
                height: 200,
              ),
              const Text(
                'Create an Account',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: nameController,
                hintText: 'Name',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: phoneController,
                hintText: 'Phone Number',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Role',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(),
                ),
                value: selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRole = newValue;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Student',
                    child: Text('Student'),
                  ),
                  DropdownMenuItem(
                    value: 'Teacher',
                    child: Text('Teacher'),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: registerUser,
              ),
              const SizedBox(height: 25),
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
                                builder: (context) => LoginPage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('or Log In here'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
