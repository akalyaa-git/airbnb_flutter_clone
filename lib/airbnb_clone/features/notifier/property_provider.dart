import 'dart:convert';
import 'package:airbnb_flutter_clone/airbnb_clone/features/model/property_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PropertyProvider with ChangeNotifier {
  List<Property> _properties = [];

  List<Property> get properties => _properties;

  Future<void> fetchProperties() async {
    final url = 'https://dummyjson.com/c/ddcc-14a3-4104-a633';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _properties = data.map((json) => Property.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load properties');
      }
    } catch (error) {
      debugPrint('Error fetching properties: $error');
    }
  }
}
