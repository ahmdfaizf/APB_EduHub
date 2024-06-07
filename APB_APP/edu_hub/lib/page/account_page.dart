import 'package:edu_hub/constant/colors.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppPalet.primary,
        title: const Text("Account", style:TextStyle(
          color: AppPalet.secondary,
          fontWeight: FontWeight.bold,
        )),
      ),
      body: const SafeArea(
        child: Text("INI ACCOUNT PAGE"),
      ),
    );
  }
}