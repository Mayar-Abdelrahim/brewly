import 'package:material_ui/material_ui.dart';
import '../core/app_colors.dart';
import '../widgets/cartitem_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.dark, size: 20),
              onPressed: () {},
            ),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Cart ", style: TextStyle(color: AppColors.dark, fontSize: 18, fontWeight: FontWeight.bold)),
            Text("(3)", style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  CartItemCard(
                    name: "Caramel Latte",
                    subtitle: "Medium · Extra Shot",
                    price: "65 EGP",
                    quantity: 2,
                    imageUrl: "https://images.unsplash.com/photo-1593443320739-77f74939d0da?q=80&w=200&auto=format&fit=crop",
                  ),
                  SizedBox(height: 16),
                  CartItemCard(
                    name: "Classic Espresso",
                    subtitle: "Small · Single",
                    price: "45 EGP",
                    quantity: 1,
                    imageUrl: "https://images.unsplash.com/photo-1510707577719-ae7c14805e3a?q=80&w=200&auto=format&fit=crop",
                  ),
                  SizedBox(height: 16),
                  CartItemCard(
                    name: "Cappuccino",
                    subtitle: "Medium · Oat Milk",
                    price: "60 EGP",
                    quantity: 1,
                    imageUrl: "https://images.unsplash.com/photo-1572442388796-11668a67e53d?q=80&w=200&auto=format&fit=crop",
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
            
            // ملخص الطلب
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  _buildSummaryRow("Subtotal", "195 EGP"),
                  const SizedBox(height: 12),
                  _buildSummaryRow("Delivery Fee", "15 EGP"),
                  const SizedBox(height: 12),
                  const Divider(color: AppColors.chip, thickness: 1, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.dark)),
                      Text("210 EGP", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // زر إتمام الطلب
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {},
                child: const Text("Place Order", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لإنشاء صف في ملخص الطلب
  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.dark)),
      ],
    );
  }
}

