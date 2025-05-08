import 'package:airbnb_flutter_clone/airbnb_clone/core/custom_navigation_bar.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/notifier/property_provider.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/home/category_selector.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/core/custom_search_bar.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/home/home_details_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/widgets/auth_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/widgets/property_details_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/widgets/property_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airbnb'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
      body: Consumer<PropertyProvider>(
        builder: (context, provider, child) {
          if (provider.properties.isEmpty) {
            provider.fetchProperties();
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomSearchBar(
                  onChanged: (_) {},
                  onSearchPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PropertySearchScreen(
                          allProperties: provider.properties,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const CategorySelector(),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.properties.length,
                    itemBuilder: (context, index) {
                      final property = provider.properties[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PropertyDetailScreen(property: property),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.all(10.0),
                          child: HomeDetailsScreen(property: property),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _logout(context);
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    // TODO: Clear authentication token or session data here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthScreen(),
      ),
    );
  }
}
