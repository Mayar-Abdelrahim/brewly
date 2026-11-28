import 'package:flutter/material.dart';
import 'package:brewly/core/app_colors.dart';
import 'package:brewly/screens/cart/order_success_dialog.dart';
import 'package:brewly/screens/cart/cartItem_card.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;
  final VoidCallback onBack;
  final VoidCallback? onOrderPlaced;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onIncrement,
    required this.onDecrement,
    required this.onBack,
    this.onOrderPlaced,
  });

  int calculateSubtotal() {
    int sum = 0;
    for (var item in cartItems) {
      final priceStr = item['priceText'] ?? item['price'] ?? '0';
      final priceNum =
          int.tryParse(priceStr.toString().replaceAll(RegExp(r'[^0-9]'), '')) ??
          0;
      final qty = (item['quantity'] as int?) ?? 1;
      sum += priceNum * qty;
    }
    return sum;
  }

  int totalItemCount() {
    int count = 0;
    for (var item in cartItems) {
      count += (item['quantity'] as int?) ?? 1;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = calculateSubtotal();
    final deliveryFee = cartItems.isEmpty ? 0 : 15;
    final totalPrice = subtotal + deliveryFee;
    final totalCount = totalItemCount();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          // back button
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.dark,
                size: 20,
              ),
              onPressed: onBack,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "My Cart ",
              style: TextStyle(
                color: AppColors.dark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "($totalCount)",
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3E6D8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 48,
                      color: Color(0xFF5C3D28),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Add some delicious coffee from the menu!",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: cartItems.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final name = item['title'] ?? item['name'] ?? '';
                        final subtitle = item['subtitle'] ?? '';
                        final price = item['priceText'] ?? item['price'] ?? '';
                        final qty = (item['quantity'] as int?) ?? 1;
                        final img = item['imagePath'] ?? item['imageUrl'] ?? '';

                        return CartItemCard(
                          name: name,
                          subtitle: subtitle,
                          price: price,
                          quantity: qty,
                          imageUrl: img,
                          onIncrement: () => onIncrement(index),
                          onDecrement: () => onDecrement(index),
                        );
                      },
                    ),
                  ),

                  // Order Summary
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow("Subtotal", "$subtotal EGP"),
                        const SizedBox(height: 12),
                        _buildSummaryRow("Delivery Fee", "$deliveryFee EGP"),
                        const SizedBox(height: 12),
                        const Divider(
                          color: AppColors.chip,
                          thickness: 1,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.dark,
                              ),
                            ),
                            Text(
                              "$totalPrice EGP",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Place Order Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        OrderSuccessDialog.show(
                          context,
                          total: totalPrice,
                          message:
                              'Your coffee order is placed and being prepared!',
                          onDone: onOrderPlaced,
                        );
                      },
                      child: const Text(
                        "Place Order",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.dark,
          ),
        ),
      ],
    );
  }
}
