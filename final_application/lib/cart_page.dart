import 'package:flutter/material.dart';
import 'package:final_application/widgets/product_card.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;
  final Function(int) onRemove;

  const CartPage({super.key, required this.cartItems, required this.onRemove});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateTotal() {
    double total = 0.0;
    for (var item in widget.cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void undoRemove(Product product) {
    setState(() {
      widget.cartItems.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Your Cart',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: widget.cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.separated(
                      itemCount: widget.cartItems.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final product = widget.cartItems[index];
                        return ListTile(
                          leading: Image.asset(
                            product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text('SAR ${(product.price * product.quantity).toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (product.quantity > 1) {
                                      product.quantity--;
                                    } else {
                                      widget.onRemove(index);
                                    }
                                  });
                                },
                              ),
                              Text(
                                product.quantity.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    product.quantity++;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  Product removedProduct = widget.cartItems[index];
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${removedProduct.name} has been removed!'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          undoRemove(removedProduct);
                                        },
                                      ),
                                    ),
                                  );
                                  widget.onRemove(index);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total: SAR ${calculateTotal().toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.brown,
                ),
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart, color: Colors.brown),
                if (widget.cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        widget.cartItems.length.toString(),
                        style: const TextStyle(
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
