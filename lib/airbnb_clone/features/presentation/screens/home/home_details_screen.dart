import 'package:airbnb_flutter_clone/airbnb_clone/features/model/property_model.dart';
import 'package:flutter/material.dart';

class HomeDetailsScreen extends StatelessWidget {
  final Property property;
  const HomeDetailsScreen({super.key, required this.property,});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
