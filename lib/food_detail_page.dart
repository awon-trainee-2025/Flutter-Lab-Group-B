import 'package:flutter/material.dart';

class FoodDetailPage extends StatelessWidget {
  final Map<String, dynamic> food;

  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          food['title'],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFFF8B400),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  food['image'],
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 16),
              Text(
                food['title'],
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Calories: ${food['calories']} kcal',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orange[800],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Ingredients:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...food['ingredients'].map((ingredient) => Text(
                    '• $ingredient',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )),
              SizedBox(height: 16),
              Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                food['instructions'],
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}