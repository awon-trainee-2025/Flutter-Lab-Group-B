import 'package:flutter/material.dart';
import 'package:final_application/widgets/product_card.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  final Function(Product) addToCart;

  const DetailPage({super.key, required this.product, required this.addToCart});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(product.image, height: 250, fit: BoxFit.cover),
                Positioned(
                  top: 10,
                  left: 1,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 1,
                  child: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Share this product!')),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Text('SAR ${product.price}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoContainer(
                  Icons.local_fire_department,
                  '${product.calories} kcal',
                ),
                _buildInfoContainer(
                  Icons.local_dining,
                  '${product.energy} kcal',
                ),
                _buildInfoContainer(Icons.star, '${product.rating}'),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'About: ${product.description}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            height: 330, 
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 215, 197, 184),
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  'SAR ${product.price}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoContainer(
                      Icons.local_fire_department,
                      '${product.calories} kcal',
                    ),
                    _buildInfoContainer(
                      Icons.local_dining,
                      '${product.energy} kcal',
                    ),
                    _buildInfoContainer(Icons.star, '${product.rating}'),
                  ],
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    addToCart(product); 
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart!')),
                    );
                  }, 
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.brown, 
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoContainer(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 5),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
