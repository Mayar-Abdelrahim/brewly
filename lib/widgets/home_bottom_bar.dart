import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const HomeBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => onTap(0),
            borderRadius: BorderRadius.circular(22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: selectedIndex == 0
                    ? const Color(0xFFF3E6D8)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 20,
                    color: selectedIndex == 0
                        ? const Color(0xFF5C3D28)
                        : const Color(0xFF7A6E66),
                  ),
                  if (selectedIndex == 0) ...[
                    const SizedBox(width: 6),
                    const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5C3D28),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () => onTap(1),
            borderRadius: BorderRadius.circular(22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: selectedIndex == 1
                    ? const Color(0xFFF3E6D8)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Icon(
                    selectedIndex == 1 ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                    color: selectedIndex == 1
                        ? const Color(0xFF5C3D28)
                        : const Color(0xFF7A6E66),
                  ),
                  if (selectedIndex == 1) ...[
                    const SizedBox(width: 6),
                    const Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5C3D28),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Cart pill
          InkWell(
            onTap: () => onTap(2),
            borderRadius: BorderRadius.circular(22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: selectedIndex == 2
                    ? const Color(0xFFF3E6D8)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 20,
                    color: selectedIndex == 2
                        ? const Color(0xFF5C3D28)
                        : const Color(0xFF7A6E66),
                  ),
                  if (selectedIndex == 2) ...[
                    const SizedBox(width: 6),
                    const Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5C3D28),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
