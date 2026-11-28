import 'package:brewly/screens/cart.dart';
import 'package:brewly/screens/favourites_screen.dart';
import 'package:brewly/widgets/coffee_product_card.dart';
import 'package:brewly/widgets/home_bottom_bar.dart';
import 'package:brewly/widgets/promo_banner_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int bottomIndex = 0;

  final List<Map<String, dynamic>> coffeeProducts = [
    {
      'title': 'Classic Espresso',
      'subtitle': 'Rich Crema',
      'priceText': '45 EGP',
      'rating': '4.8',
      'imagePath': 'assets/images/classic_espresso.png',
      'isFavorite': false,
    },
    {
      'title': 'Caramel Latte',
      'subtitle': 'With Milk',
      'priceText': '65 EGP',
      'rating': '4.7',
      'imagePath': 'assets/images/caramel_latte.png',
      'isFavorite': true,
    },
    {
      'title': 'Iced Cold Brew',
      'subtitle': 'Slow Steeped',
      'priceText': '70 EGP',
      'rating': '4.9',
      'imagePath': 'assets/images/iced_cold_brew.png',
      'isFavorite': true,
    },
    {
      'title': 'Cappuccino',
      'subtitle': 'Velvet Foam',
      'priceText': '60 EGP',
      'rating': '4.6',
      'imagePath': 'assets/images/cappuccino.png',
      'isFavorite': false,
    },
    {
      'title': 'Mocha',
      'subtitle': 'Chocolate Delight',
      'priceText': '75 EGP',
      'rating': '4.9',
      'imagePath': 'assets/images/caramel_latte_1.png',
      'isFavorite': false,
    },
    {
      'title': 'Vanilla Latte',
      'subtitle': 'Smooth Vanilla',
      'priceText': '68 EGP',
      'rating': '4.8',
      'imagePath': 'assets/images/classic_espresso_1.png',
      'isFavorite': false,
    },
    {
      'title': 'Classic Espresso',
      'subtitle': 'Rich Crema',
      'priceText': '45 EGP',
      'rating': '4.8',
      'imagePath': 'assets/images/classic_espresso.png',
      'isFavorite': false,
    },
    {
      'title': 'Caramel Latte',
      'subtitle': 'With Milk',
      'priceText': '65 EGP',
      'rating': '4.7',
      'imagePath': 'assets/images/caramel_latte.png',
      'isFavorite': true,
    },
    {
      'title': 'Iced Cold Brew',
      'subtitle': 'Slow Steeped',
      'priceText': '70 EGP',
      'rating': '4.9',
      'imagePath': 'assets/images/iced_cold_brew.png',
      'isFavorite': true,
    },
    {
      'title': 'Cappuccino',
      'subtitle': 'Velvet Foam',
      'priceText': '60 EGP',
      'rating': '4.6',
      'imagePath': 'assets/images/cappuccino.png',
      'isFavorite': false,
    },
    {
      'title': 'Mocha',
      'subtitle': 'Chocolate Delight',
      'priceText': '75 EGP',
      'rating': '4.9',
      'imagePath': 'assets/images/caramel_latte_1.png',
      'isFavorite': false,
    },
    {
      'title': 'Vanilla Latte',
      'subtitle': 'Smooth Vanilla',
      'priceText': '68 EGP',
      'rating': '4.8',
      'imagePath': 'assets/images/classic_espresso_1.png',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF4EC),
      bottomNavigationBar: HomeBottomBar(
        selectedIndex: bottomIndex,
        onTap: (index) {
          setState(() => bottomIndex = index);
        },
      ),
      body: bottomIndex == 2
          ? const CartScreen()
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
                                color: Color(0xFF8C7E74),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Welcome to Brewly',
                              style: TextStyle(
                                color: Color(0xFF1E1815),
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: Color(0xFF1E1815),
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
                        color: Color(0xFF1E1815),
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
                              onAddTap: () {},
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
