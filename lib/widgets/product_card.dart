import 'package:material_ui/material_ui.dart';
import '../core/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(imageUrl, height: 130, width: double.infinity, fit: BoxFit.cover),
              ),
              
              Positioned(
                top: 8, right: 8,
                child: Container(
                  width: 32, height: 32,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.favorite_border, size: 18, color: AppColors.dark),
                ),
              ),
              
              Positioned(
                bottom: 8, left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: AppColors.accent),
                      const SizedBox(width: 4),
                      Text(rating.toString(), style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          
          Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.dark)),
          const SizedBox(height: 4),
          
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
              Container(
                width: 34, height: 34,
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}