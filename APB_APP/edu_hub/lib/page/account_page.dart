import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 50,
      //   backgroundColor: AppPalet.primary,
      //   title: const Text("Account", style: TextStyle(
      //     color: AppPalet.secondary,
      //     fontWeight: FontWeight.bold,
      //   )),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://www.example.com/profile_image.png'),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'John Doe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    'john.doe@example.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    // Navigate to settings screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle logout
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
