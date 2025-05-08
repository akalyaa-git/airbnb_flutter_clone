import 'package:airbnb_flutter_clone/airbnb_clone/core/custom_navigation_bar.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/notifier/wishlist_provider.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/home/home_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistsScreen extends StatelessWidget {
  const WishlistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context).wishlist;

    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist')),
      body: wishlist.isEmpty
          ? const Center(child: Text('No properties in wishlist'))
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: wishlist.length,
                itemBuilder: (ctx, index) {
                  final property = wishlist[index];
                  return Card(
                    margin: EdgeInsets.all(
                      10,
                    ),
                    child: HomeDetailsScreen(property: property),
                  );
                },
              ),
            ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}
