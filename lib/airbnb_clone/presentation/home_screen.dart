import 'package:airbnb_flutter_clone/airbnb_clone/notifier/property_provider.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/presentation/auth_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/presentation/property_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airbnb Clone'),
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

          return ListView.builder(
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
                  margin: EdgeInsets.all(
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        property.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              property.location,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$${property.price}/night',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  property.rating.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            property.isAvailable
                                ? Text(
                                    'Available',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  )
                                : Text(
                                    'Not Available',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
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
