class Property {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String location;
  final double rating;
  final bool isAvailable;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.location,
    required this.rating,
    required this.isAvailable,
  });

  // Factory method to parse from JSON
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      location: json['location'],
      rating: json['rating'].toDouble(),
      isAvailable: json['isAvailable'],
    );
  }
}
