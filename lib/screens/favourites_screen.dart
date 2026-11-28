import 'package:brewly/widgets/coffee_product_card.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;
  final ValueChanged<int> onFavoriteToggle;
  final VoidCallback onExploreMenu;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
    required this.onExploreMenu,
  });

  @override
  Widget build(BuildContext context) {
    // Build a list of (originalIndex, item) for favorites only
    final favItems = <MapEntry<int, Map<String, dynamic>>>[];
    for (int i = 0; i < favorites.length; i++) {
      if (favorites[i]['isFavorite'] == true) {
        favItems.add(MapEntry(i, favorites[i]));
      }
    }

    return SafeArea(
      child: favItems.isEmpty
          ? _buildEmptyState()
          : _buildFavoritesList(favItems),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Favorites',
                    style: TextStyle(
                      color: Color(0xFF1E1815),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text('❤️', style: TextStyle(fontSize: 20)),
                ],
              ),
            ],
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3E6D8),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('☕', style: TextStyle(fontSize: 50)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'No favorites yet',
                    style: TextStyle(
                      color: Color(0xFF1E1815),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap the heart on any drink to save\nit here',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF8C7E74), fontSize: 14),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 180,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: onExploreMenu,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5C3D28),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Explore Menu',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(
    List<MapEntry<int, Map<String, dynamic>>> favItems,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Favorites',
                style: TextStyle(
                  color: Color(0xFF1E1815),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 6),
              Text('❤️', style: TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 18),
          GridView.builder(
            itemCount: favItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final originalIndex = favItems[index].key;
              final item = favItems[index].value;
              return CoffeeProductCard(
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
                priceText: item['priceText'] as String,
                rating: item['rating'] as String,
                imagePath: item['imagePath'] as String,
                isFavorite: true,
                onFavoriteTap: () {
                  onFavoriteToggle(originalIndex);
                },
                onAddTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
