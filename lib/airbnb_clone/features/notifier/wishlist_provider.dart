import 'package:airbnb_flutter_clone/airbnb_clone/features/model/property_model.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  final List<Property> _wishlist = [];

  List<Property> get wishlist => _wishlist;

  bool isInWishlist(Property property) {
    return _wishlist.any((item) => item.id == property.id);
  }

  void toggleWishlist(Property property) {
    if (isInWishlist(property)) {
      _wishlist.removeWhere((item) => item.id == property.id);
    } else {
      _wishlist.add(property);
    }
    notifyListeners();
  }
}
