import 'package:flutter/material.dart';
import 'data.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FoodData item;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 5.0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name, style: tt.headlineSmall),
          Text(item.brand),
          const SizedBox(height: 4),
          Text('\$ ${item.price}', style: tt.headlineMedium),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category(this.title, this.count, {super.key, this.color});

  final String title;
  final int count;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(8.0),
      width: 120,
      decoration: BoxDecoration(
        color: color ?? Colors.blue.shade400,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Stack(
        children: [
          Text(title, style: tt.titleLarge?.copyWith(color: Colors.white)),
          Positioned(
            bottom: 0,
            child: Text(
              '$count items',
              style: tt.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
