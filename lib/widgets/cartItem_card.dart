import 'package:material_ui/material_ui.dart';
import '../core/app_colors.dart';

class CartItemCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String price;
  final int quantity;
  final String imageUrl;

  const CartItemCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(imageUrl, width: 76, height: 76, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.dark)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary)),
              ],
            ),
          ),
          
          
          Row(
            children: [
              Container(
                width: 30, height: 30,
                decoration: const BoxDecoration(color: AppColors.chip, shape: BoxShape.circle),
                child: const Icon(Icons.remove, size: 16, color: AppColors.dark),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Container(
                width: 30, height: 30,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(Icons.add, size: 16, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}