import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'food_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required List favoriteRecipes});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> favoriteRecipes = [];
  String searchQuery = "";
  String selectedCategory = "All"; 


  final List<Map<String, dynamic>> foodList = [
    {
      'title': 'Pancakes',
      'subtitle': 'Fluffy pancakes with syrup',
      'image': 'images/pancakes.png',
      'category': 'Breakfast',
      'calories': 250,
      'ingredients': [
        '1 cup all-purpose flour',
        '1 tablespoon sugar',
        '2 teaspoons baking powder',
        '1/2 teaspoon salt',
        '1 cup milk',
        '1 egg',
        '2 tablespoons melted butter',
        '1 teaspoon vanilla extract'
      ],
      'instructions': '1. In a bowl, mix all dry ingredients. 2. Add wet ingredients and stir until smooth. 3. Heat a pan and cook pancakes on both sides until golden brown.',
    },
    {
      'title': 'Oatmeal',
      'subtitle': 'Oats, fruits and honey',
      'image': 'images/oatmeal.png',
      'category': 'Breakfast',
      'calories': 150,
      'ingredients': [
        '1/2 cup oats',
        '1 cup milk',
        '1 tablespoon honey',
        '1/2 banana, sliced',
        '1/4 cup berries'
      ],
      'instructions': '1. Cook oats in milk until thickened. 2. Add honey and mix. 3. Top with sliced banana and berries.',
    },
    {
      'title': 'Burger',
      'subtitle': 'Classic beef burger with lettuce and cheese',
      'image': 'images/burger.png',
      'category': 'Lunch',
      'calories': 500,
      'ingredients': [
        '1 beef patty',
        '1 burger bun',
        'Lettuce',
        'Tomato',
        'Cheese slice',
        'Ketchup and mustard'
      ],
      'instructions': '1. Grill beef patty until fully cooked. 2. Toast burger bun. 3. Assemble with lettuce, tomato, cheese, and sauces.',
    },
    {
      'title': 'Pizza',
      'subtitle': 'Delicious homemade pizza with mozzarella and toppings',
      'image': 'images/pizza.png',
      'category': 'Lunch',
      'calories': 300,
      'ingredients': [
        '1 pizza dough',
        '1/2 cup tomato sauce',
        '1 cup mozzarella cheese',
        'Toppings: pepperoni, olives, bell peppers, onions'
      ],
      'instructions': '1. Preheat oven to 220°C. 2. Roll dough, spread tomato sauce, add cheese and toppings. 3. Bake for 10-15 minutes.',
    },
    {
      'title': 'Kabsa',
      'subtitle': 'Traditional Saudi rice dish with chicken and spices',
      'image': 'images/kabsa.png',
      'category': 'Lunch',
      'calories': 600,
      'ingredients': [
        '1 chicken, cut into pieces',
        '2 cups basmati rice',
        '1 onion, chopped',
        '2 tomatoes, chopped',
        'Spices: cinnamon, cumin, turmeric, cloves'
      ],
      'instructions': '1. Brown chicken in a pot with onions. 2. Add tomatoes and spices, cook until soft. 3. Add rice and water, cook until rice is tender.',
    },
    {
      'title': 'Pasta',
      'subtitle': 'Pasta with creamy sauce and mushrooms',
      'image': 'images/pasta.png',
      'category': 'Dinner',
      'calories': 400,
      'ingredients': [
        '200g pasta',
        '1 cup cream',
        '1/2 cup mushrooms, sliced',
        '2 cloves garlic, minced',
        'Parmesan cheese'
      ],
      'instructions': '1. Cook pasta according to package instructions. 2. In a pan, sauté garlic and mushrooms, then add cream. 3. Combine pasta with sauce and serve with Parmesan.',
    },
    {
      'title': 'Taco',
      'subtitle': 'Crispy tacos with beef, cheese, and veggies',
      'image': 'images/taco.png',
      'category': 'Dinner',
      'calories': 350,
      'ingredients': [
        'Taco shells',
        'Ground beef',
        'Lettuce, tomato, onion',
        'Cheese',
        'Sour cream and salsa'
      ],
      'instructions': '1. Cook ground beef and season with taco seasoning. 2. Assemble tacos with beef, lettuce, cheese, and sauces.',
    },
    {
      'title': 'Eggs',
      'subtitle': 'Scrambled eggs with a side of toast',
      'image': 'images/eggs.png',
      'category': 'Breakfast',
      'calories': 200,
      'ingredients': [
        '2 eggs',
        '1 tablespoon butter',
        'Salt and pepper to taste',
        '2 slices of bread'
      ],
      'instructions': '1. Scramble eggs with butter, salt, and pepper. 2. Toast bread slices and serve with scrambled eggs.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = foodList.where((food) {
      bool matchesSearch = food['title'].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || food['category'] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Recipes Today"),
        backgroundColor: const Color(0xFFF8B400),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoritesPage(favorites: favoriteRecipes)),
              );
            },
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ["All", "Breakfast", "Lunch", "Dinner"].map((category) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: selectedCategory == category ? Colors.orange : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: selectedCategory == category ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                
                // شريط البحث
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search recipes...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                
                
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      final isFavorite = favoriteRecipes.contains(item);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FoodDetailPage(food: item),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  child: Image.asset(
                                    item['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['subtitle'],
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF8B400),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.local_fire_department, size: 16, color: Colors.white),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${item['calories']} cal",
                                            style: const TextStyle(color: Colors.white, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(
                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                          color: const Color(0xFFF8B400),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (isFavorite) {
                                              favoriteRecipes.remove(item);
                                            } else {
                                              favoriteRecipes.add(item);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : FavoritesPage(favorites: favoriteRecipes),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}