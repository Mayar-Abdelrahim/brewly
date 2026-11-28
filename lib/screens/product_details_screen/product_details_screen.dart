import 'package:brewly/core/app_colors.dart';
import 'package:flutter/material.dart';

class _Extra {
  final String name;
  final int price;

  const _Extra(this.name, this.price);
}

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final ValueChanged<Map<String, dynamic>>? onAddToCart;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.onAddToCart,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  static const Color _brown = AppColors.primary;
  static const Color _dark = AppColors.darkText;
  static const Color _muted = AppColors.textSecondary;
  static const Color _border = AppColors.border;

  late int _basePrice;
  static const List<String> _sizes = ['S', 'M', 'L'];
  static const List<_Extra> _extras = [
    _Extra('Extra Sugar', 0),
    _Extra('Whipped Cream', 10),
    _Extra('Extra Shot', 15),
    _Extra('Oat Milk', 12),
  ];

  String? _size;
  final Set<int> _selectedExtras = {};
  final _quantity = 1;
  late bool _favorite;

  @override
  void initState() {
    super.initState();
    final priceStr =
        widget.product['priceText'] ?? widget.product['price'] ?? '65';
    _basePrice =
        int.tryParse(priceStr.toString().replaceAll(RegExp(r'[^0-9]'), '')) ??
        65;
    _favorite = (widget.product['isFavorite'] as bool?) ?? false;
  }

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
    final title = widget.product['title'] ?? 'Coffee';
    final extrasList = _selectedExtras.map((i) => _extras[i].name).toList();
    final extrasText = extrasList.isEmpty ? '' : ' · ${extrasList.join(', ')}';
    final chosenSize = _size ?? 'S';
    final sizeText = 'Size $chosenSize';
    final customSubtitle = extrasList.isEmpty
        ? sizeText
        : '$sizeText$extrasText';

    if (widget.onAddToCart != null) {
      widget.onAddToCart!({
        'title': title,
        'subtitle': customSubtitle,
        'priceText': '$_total EGP',
        'imagePath': widget.product['imagePath'],
        'quantity': _quantity,
      });
    }

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text('$title added to cart!'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.product['title'] ?? 'Coffee';
    final subtitle = widget.product['subtitle'] ?? 'Fresh & Delicious Brew';
    final imagePath = widget.product['imagePath'] as String?;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, imagePath),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleRow(title),
                        const SizedBox(height: 10),
                        Text(
                          widget.product['description'] ??
                              '$subtitle — freshly prepared with premium roasted beans and rich flavors.',
                          style: const TextStyle(
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

  Widget _buildHeader(BuildContext context, String? imagePath) {
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
              child: imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        imagePath,
                        width: 170,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
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
                    onTap: () {
                      setState(() {
                        _favorite = !_favorite;
                        widget.product['isFavorite'] = _favorite;
                      });
                    },
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

  Widget _buildTitleRow(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
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
      children: List.generate(_extras.length, (i) {
        final extra = _extras[i];
        final checked = _selectedExtras.contains(i);
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () => _toggleExtra(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: checked ? _brown : _border,
                  width: checked ? 1.8 : 1.2,
                ),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: checked ? _brown : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: checked ? _brown : const Color(0xFFBCAAA4),
                        width: 1.8,
                      ),
                    ),
                    child: checked
                        ? const Icon(Icons.check, size: 15, color: Colors.white)
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
                    extra.price == 0 ? 'Free' : '+${extra.price} EGP',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: checked ? _brown : _muted,
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
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
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
}
