import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Farms',
      'Icons',
      'Amazing pools',
      'Beachfront',
      'Mansions',
      'Surfing',
    ];

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final icon = categoryIcons[category] ?? Icons.bed;

          return Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Column(
              children: [
                Icon(icon, size: 24),
                Text(category, style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}

final categoryIcons = {
  'Farms': Icons.agriculture,
  'Icons': Icons.confirmation_num_outlined,
  'Amazing pools': Icons.pool,
  'Beachfront': Icons.beach_access,
  'Mansions': Icons.house,
  'Surfing': Icons.surfing,
};
