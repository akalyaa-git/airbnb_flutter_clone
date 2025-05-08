import 'package:airbnb_flutter_clone/airbnb_clone/features/model/property_model.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/notifier/wishlist_provider.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/widgets/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Property property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  _PropertyDetailScreenState createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(today.year + 1),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      _showConfirmationDialog();
    }
  }

  void _showConfirmationDialog() {
    if (_selectedDate == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Booking"),
        content: Text(
            "Do you want to book ${widget.property.title} on ${_selectedDate!.toLocal().toString().split(' ')[0]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                          property: widget.property,
                        )),
              );
              // _confirmBooking();
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _confirmBooking() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "✅ Booking Confirmed for ${widget.property.title} on ${_selectedDate!.toLocal().toString().split(' ')[0]}"),
        duration: Duration(seconds: 3),
      ),
    );
    Future.delayed(
        Duration(seconds: 2), () => Navigator.pop(context)); // Navigate back
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final isFavorite = wishlistProvider.isInWishlist(widget.property);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.property.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.property.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      top: 12,
                      right: 12,
                      child: IconButton(
                        icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red),
                        onPressed: () {
                          wishlistProvider.toggleWishlist(widget.property);
                        },
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(
                  16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.property.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.property.location,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.property.rating.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.property.description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$${widget.property.price}/night',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    widget.property.isAvailable
                        ? ElevatedButton(
                            onPressed: () => _selectDate(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text(
                              "Book Now",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : Text(
                            "Not Available",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
