import 'package:airbnb_flutter_clone/airbnb_clone/core/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Your profile settings go here.')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}
