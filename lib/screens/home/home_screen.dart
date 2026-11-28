import 'package:brewly/core/app_colors.dart';
import 'package:brewly/screens/cart/cart_screen.dart';
import 'package:brewly/screens/favourites/favourites_screen.dart';
import 'package:brewly/screens/product_details_screen/product_details_screen.dart';
import 'package:brewly/widgets/coffee_product_card.dart';
import 'package:brewly/screens/home/home_bottom_bar.dart';
import 'package:brewly/screens/home/promo_banner_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int bottomIndex = 0;

  final List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingIndex = cartItems.indexWhere(
        (item) =>
            item['title'] == product['title'] &&
            item['subtitle'] == product['subtitle'],
      );
      if (existingIndex >= 0) {
        final addedQty = (product['quantity'] as int?) ?? 1;
        cartItems[existingIndex]['quantity'] =
            (cartItems[existingIndex]['quantity'] as int) + addedQty;
      } else {
        cartItems.add({
          'title': product['title'],
          'subtitle': product['subtitle'],
          'priceText': product['priceText'],
          'imagePath': product['imagePath'],
          'quantity': (product['quantity'] as int?) ?? 1,
        });
      }
    });

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text('${product['title']} added to cart!'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void incrementCartItem(int index) {
    setState(() {
      cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int) + 1;
    });
  }

  void decrementCartItem(int index) {
    setState(() {
      final currentQty = cartItems[index]['quantity'] as int;
      if (currentQty > 1) {
        cartItems[index]['quantity'] = currentQty - 1;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  final List<Map<String, dynamic>> coffeeProducts = [
    {
      'title': 'Classic Espresso',
      'subtitle': 'Rich Crema',
      'description':
          'A bold and concentrated shot of pure espresso with a velvety, golden-brown crema on top.',
      'priceText': '45 EGP',
      'rating': '4.8',
      'imagePath': 'assets/images/classic_espresso.png',
      'isFavorite': false,
    },
    {
      'title': 'Caramel Latte',
      'subtitle': 'With Milk',
      'description':
          'Smooth espresso blended with steamed creamy milk and swirled with buttery golden caramel.',
      'priceText': '65 EGP',
      'rating': '4.7',
      'imagePath': 'assets/images/caramel_latte.png',
      'isFavorite': true,
    },
    {
      'title': 'Iced Cold Brew',
      'subtitle': 'Slow Steeped',
      'description':
          'Steeped for over 16 hours in cold filtered water for an ultra-smooth, refreshing, and crisp coffee taste.',
      'priceText': '70 EGP',
      'rating': '4.9',
      'imagePath': 'assets/images/iced_cold_brew.png',
      'isFavorite': true,
    },
    {
      'title': 'Cappuccino',
      'subtitle': 'Velvet Foam',
      'description':
          'Equal parts robust espresso, rich steamed milk, and a thick cloud of airy velvet foam.',
      'priceText': '60 EGP',
      'rating': '4.6',
      'imagePath': 'assets/images/cappuccino.png',
      'isFavorite': false,
    },
    {
      'title': 'Mocha',
      'subtitle': 'Chocolate Delight',
      'description':
          'A sweet harmony of rich roasted espresso, dark Dutch chocolate, and steamed whole milk.',
      'priceText': '75 EGP',
      'rating': '4.9',
      'imagePath': 'assets/images/caramel_latte_1.png',
      'isFavorite': false,
    },
    {
      'title': 'Vanilla Latte',
      'subtitle': 'Smooth Vanilla',
      'description':
          'A comforting blend of delicate Madagascar vanilla syrup, rich espresso, and silky steamed milk.',
      'priceText': '68 EGP',
      'rating': '4.8',
      'imagePath': 'assets/images/classic_espresso_1.png',
      'isFavorite': false,
    },
    {
      'title': 'Classic Espresso',
      'subtitle': 'Rich Crema',
      'description':
          'A bold and concentrated shot of pure espresso with a velvety, golden-brown crema on top.',
      'priceText': '45 EGP',
      'rating': '4.8',
      'imagePath': 'assets/images/classic_espresso.png',
      'isFavorite': false,
    },
    {
      'title': 'Caramel Latte',
      'subtitle': 'With Milk',
      'description':
          'Smooth espresso blended with steamed creamy milk and swirled with buttery golden caramel.',
      'priceText': '65 EGP',
      'rating': '4.7',
      'imagePath': 'assets/images/caramel_latte.png',
      'isFavorite': true,
    },
    {
      'title': 'Iced Cold Brew',
      'subtitle': 'Slow Steeped',
      'description':
          'Steeped for over 16 hours in cold filtered water for an ultra-smooth, refreshing, and crisp coffee taste.',
      'priceText': '70 EGP',
      'rating': '4.9',
      'imagePath': 'assets/images/iced_cold_brew.png',
      'isFavorite': true,
    },
    {
      'title': 'Cappuccino',
      'subtitle': 'Velvet Foam',
      'description':
          'Equal parts robust espresso, rich steamed milk, and a thick cloud of airy velvet foam.',
      'priceText': '60 EGP',
      'rating': '4.6',
      'imagePath': 'assets/images/cappuccino.png',
      'isFavorite': false,
    },
    {
      'title': 'Mocha',
      'subtitle': 'Chocolate Delight',
      'description':
          'A sweet harmony of rich roasted espresso, dark Dutch chocolate, and steamed whole milk.',
      'priceText': '75 EGP',
      'rating': '4.9',
      'imagePath': 'assets/images/caramel_latte_1.png',
      'isFavorite': false,
    },
    {
      'title': 'Vanilla Latte',
      'subtitle': 'Smooth Vanilla',
      'description':
          'A comforting blend of delicate Madagascar vanilla syrup, rich espresso, and silky steamed milk.',
      'priceText': '68 EGP',
      'rating': '4.8',
      'imagePath': 'assets/images/classic_espresso_1.png',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: HomeBottomBar(
        selectedIndex: bottomIndex,
        onTap: (index) {
          setState(() => bottomIndex = index);
        },
      ),
      body: bottomIndex == 2
          ? CartScreen(
              cartItems: cartItems,
              onIncrement: incrementCartItem,
              onDecrement: decrementCartItem,
              onBack: () {
                setState(() => bottomIndex = 0);
              },
              onOrderPlaced: () {
                setState(() {
                  cartItems.clear();
                  bottomIndex = 0;
                });
              },
            )
          : bottomIndex == 1
          ? FavoritesScreen(
              favorites: coffeeProducts,
              onFavoriteToggle: (index) {
                setState(() {
                  coffeeProducts[index]['isFavorite'] =
                      !(coffeeProducts[index]['isFavorite'] as bool);
                });
              },
              onExploreMenu: () {
                setState(() => bottomIndex = 0);
              },
              onAddToCart: addToCart,
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning ⛅',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Welcome to Brewly',
                              style: TextStyle(
                                color: AppColors.dark,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: const BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: AppColors.dark,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    PromoBannerCard(),
                    const SizedBox(height: 30),

                    const Text(
                      'Our Menu 🧾',
                      style: TextStyle(
                        color: AppColors.dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                      children: coffeeProducts
                          .map(
                            (p) => CoffeeProductCard(
                              title: p['title'] as String,
                              subtitle: p['subtitle'] as String,
                              priceText: p['priceText'] as String,
                              rating: p['rating'] as String,
                              imagePath: p['imagePath'] as String?,
                              isFavorite: p['isFavorite'] as bool,
                              onFavoriteTap: () {
                                setState(() {
                                  p['isFavorite'] = !(p['isFavorite'] as bool);
                                });
                              },
                              onAddTap: () => addToCart(p),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailsScreen(
                                      product: p,
                                      onAddToCart: (item) => addToCart(item),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
