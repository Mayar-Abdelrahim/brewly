import 'package:flutter/material.dart';

import 'order_success_dialog.dart';

class _Extra {
  final String name;
  final int price;

  const _Extra(this.name, this.price);
}

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  static const Color _brown = Color(0xFF6F4E37);
  static const Color _dark = Color(0xFF3E2723);
  static const Color _muted = Color(0xFF8D7B6F);
  static const Color _border = Color(0xFFE8DCCF);

  static const int _basePrice = 65;
  static const List<String> _sizes = ['S', 'M', 'L'];
  static const List<_Extra> _extras = [
    _Extra('Extra Sugar', 0),
    _Extra('Whipped Cream', 10),
    _Extra('Extra Shot', 15),
    _Extra('Oat Milk', 12),
  ];

  String _size = 'M';
  final Set<int> _selectedExtras = {2};
  int _quantity = 1;
  bool _favorite = false;

  int get _extrasTotal =>
      _selectedExtras.fold<int>(0, (sum, i) => sum + _extras[i].price);

  int get _total => (_basePrice + _extrasTotal) * _quantity;

  void _toggleExtra(int index) {
    setState(() {
      if (_selectedExtras.contains(index)) {
        _selectedExtras.remove(index);
      } else {
        _selectedExtras.add(index);
      }
    });
  }

  void _addToCart() {
    OrderSuccessDialog.show(context, total: _total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleRow(),
                        const SizedBox(height: 10),
                        const Text(
                          'Rich espresso with steamed milk and a drizzle of '
                          'golden caramel syrup.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: _muted,
                          ),
                        ),
                        const SizedBox(height: 26),
                        _sectionTitle('Size'),
                        const SizedBox(height: 12),
                        _buildSizes(),
                        const SizedBox(height: 26),
                        _sectionTitle('Extras'),
                        const SizedBox(height: 12),
                        _buildExtras(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC8854A), Color(0xFF6F4E37), Color(0xFF3E2723)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 170,
                height: 170,
                decoration: const BoxDecoration(
                  color: Color(0x26FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_cafe,
                  size: 96,
                  color: Color(0xFFFFF1DF),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  _circleButton(
                    icon: _favorite ? Icons.favorite : Icons.favorite_border,
                    iconColor: _favorite ? const Color(0xFFE53935) : _dark,
                    onTap: () => setState(() => _favorite = !_favorite),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = _dark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'Caramel Latte',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: _dark,
            ),
          ),
        ),
        Text(
          '$_basePrice EGP',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _brown,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: _dark,
      ),
    );
  }

  Widget _buildSizes() {
    return Row(
      children: _sizes.map((s) {
        final selected = s == _size;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => setState(() => _size = s),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 64,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? _brown : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected ? _brown : _border,
                  width: 1.5,
                ),
              ),
              child: Text(
                s,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : _dark,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExtras() {
    return Column(
      children: List<Widget>.generate(_extras.length, (i) {
        final extra = _extras[i];
        final selected = _selectedExtras.contains(i);
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _toggleExtra(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFF6EADD) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected ? _brown : _border,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected ? _brown : Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: selected ? _brown : _border,
                        width: 1.5,
                      ),
                    ),
                    child: selected
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      extra.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                  ),
                  Text(
                    '+${extra.price} EGP',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _brown,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _buildStepper(),
            const SizedBox(width: 14),
            Expanded(
              child: SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brown,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Add to Cart · $_total EGP',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
            icon: const Icon(Icons.remove, size: 20),
            color: _dark,
          ),
          SizedBox(
            width: 24,
            child: Text(
              '$_quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: _dark,
              ),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _quantity++),
            icon: const Icon(Icons.add, size: 20),
            color: _dark,
          ),
        ],
      ),
    );
  }
}
