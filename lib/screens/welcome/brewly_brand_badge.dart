import 'package:flutter/material.dart';

class BrewlyBrandBadge extends StatelessWidget {
  const BrewlyBrandBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFF2B231E).withValues(alpha: 0.75),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.coffee_outlined,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Brewly',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}