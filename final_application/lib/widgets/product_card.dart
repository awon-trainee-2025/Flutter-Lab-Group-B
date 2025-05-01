import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final double rating;
  final String image;
  final String description;
  final int calories;
  final int energy;
  int quantity; 
  Product({
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
    required this.description,
    required this.calories,
    required this.energy,
    this.quantity = 1, 
  });
}


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text(
                  product.rating.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Image.asset(
              product.image,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.description, style: TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SAR ${product.price.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onAddToCart, 
                    child: Icon(Icons.add), 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}