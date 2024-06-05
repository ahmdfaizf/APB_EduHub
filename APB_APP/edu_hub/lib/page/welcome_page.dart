import 'package:edu_hub/constant/colors.dart';
import 'package:edu_hub/page/main_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Image.asset(
                "assets/LogoEduHub.png",
                height: 250,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Welcome :)",
              style: TextStyle(
                  fontSize: 27,
                  color: Color.fromARGB(255, 0, 43, 53),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 43, 53))),
                child: const Center(
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 43, 53)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 43, 53))),
                child: const Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 43, 53)),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
