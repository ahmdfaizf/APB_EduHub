import 'package:edu_hub/constant/colors.dart';
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
              colors: [
                AppPalet.primary,
                Color.fromARGB(193, 99, 171, 207)]
            )
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Image.asset("assets/LogoEduHub.png", height: 250,),
              ),
              SizedBox(
                height: 50,
              ),
              Text("Welcome", style: TextStyle(
                fontSize: 27,
                color: Color.fromARGB(255 , 0, 43, 53),
                fontWeight: FontWeight.bold
              ),),
              Text("HALOOOOO")
            ],
          ),
        )),
    );
  }
}