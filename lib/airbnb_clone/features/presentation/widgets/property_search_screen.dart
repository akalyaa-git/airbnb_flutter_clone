import 'package:airbnb_flutter_clone/airbnb_clone/features/model/property_model.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/home/home_details_screen.dart';
import 'package:flutter/material.dart';

class PropertySearchScreen extends StatefulWidget {
  final List<Property> allProperties;

  const PropertySearchScreen({super.key, required this.allProperties});

  @override
  State<PropertySearchScreen> createState() => _PropertySearchScreenState();
}

class _PropertySearchScreenState extends State<PropertySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Property> _filteredProperties = [];

  void _searchProperty() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredProperties = widget.allProperties.where((property) {
        return property.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasResults = _filteredProperties.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Start your search',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchProperty,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? const Center(child: Text('Enter a search term above.'))
                : hasResults
                    ? ListView.builder(
                        itemCount: _filteredProperties.length,
                        itemBuilder: (context, index) {
                          final property = _filteredProperties[index];
                          return Card(
                            margin: EdgeInsets.all(
                              10,
                            ),
                            child: HomeDetailsScreen(property: property),
                          );
                        },
                      )
                    : const Center(child: Text('No results found.')),
          ),
        ],
      ),
    );
  }
}
