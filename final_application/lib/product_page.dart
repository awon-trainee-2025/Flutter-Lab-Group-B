import 'package:flutter/material.dart';
import 'package:final_application/cart_page.dart';
import 'package:final_application/detail_page.dart';
import 'package:final_application/widgets/product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> products = [
    Product(
      name: 'Latte',price: 15.0,rating: 4.8,
      image: 'images/latte.jpg',description: 'A creamy espresso with steamed milk.',
      calories: 200,energy: 150,),
    Product(
      name: 'Black Coffee',price: 18.0,rating: 4.6,
      image: 'images/black coffee.png',description: 'Rich brewed coffee for an energizing experience.',
      calories: 5,energy: 0,),
    Product(
      name: 'Tea',price: 10.0, rating: 4.5,
      image: 'images/tea.png',description: 'Refreshing tea infused with unique flavors.',
      calories: 30,energy: 0,),
    Product(
      name: 'Espresso',price: 12.0,rating: 4.7,
      image: 'images/Espresso.jpg',description: 'Bold espresso shot for a quick boost.',
      calories: 10, energy: 0,), ];

  List<Product> filteredProducts = [];
  String searchQuery = '';
  List<Product> cartItems = [];
  String? selectedCategory = 'All'; 

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void filterProducts(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList(); });}

  void filterByCategory(String? category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        filteredProducts = products;
      } else if (category == 'Coffee') {
        filteredProducts = products.where((product) =>
          product.name.toLowerCase().contains('coffee') ||
          product.name.toLowerCase().contains('latte') ||
          product.name.toLowerCase().contains('espresso')
        ).toList();
      } else if (category == 'Tea') {
        filteredProducts = products.where((product) =>
          product.name.toLowerCase().contains('tea')
        ).toList();
      }
    });
  }

  void addToCart(Product product) {
  setState(() {
    int index = cartItems.indexWhere((item) => item.name == product.name);

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(Product(
        name: product.name,
        price: product.price,
        rating: product.rating,
        image: product.image,
        description: product.description,
        calories: product.calories,
        energy: product.energy,
        quantity: 1,
      ));
    }
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('${product.name} added to cart!')),
  );}

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome to Coffee Shop',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                Icon(Icons.menu, color: Colors.brown),
              ],
            ),
          ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Brewed fresh, served with love.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: filterProducts,
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCategory,
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: false,
                  onChanged: (String? newValue) {
                    filterByCategory(newValue);
                  },
                  items: <String>['All', 'Coffee', 'Tea']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: filteredProducts[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          product: filteredProducts[index],
                          addToCart: addToCart,
                        ),
                      ),
                    );
                  },
                  onAddToCart: () => addToCart(filteredProducts[index]),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart, color: Colors.brown),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cartItems.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(
                  cartItems: cartItems,
                  onRemove: removeFromCart,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
