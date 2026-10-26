import 'package:flutter/material.dart';

import '../models/product.dart';

extension ProductCategoryStyle on ProductCategory {
  IconData get icon {
    switch (this) {
      case ProductCategory.greenBean:
        return Icons.eco;
      case ProductCategory.roasted:
        return Icons.coffee;
      case ProductCategory.ground:
        return Icons.grain;
    }
  }

  Color get color {
    switch (this) {
      case ProductCategory.greenBean:
        return const Color(0xFF6B8E4E);
      case ProductCategory.roasted:
        return const Color(0xFF6F4E37);
      case ProductCategory.ground:
        return const Color(0xFF8D6E63);
    }
  }
}

/// Pengganti foto produk: blok gradasi dengan ikon kategori.
class CoverArt extends StatelessWidget {
  const CoverArt({
    super.key,
    required this.category,
    this.height = 96,
    this.width,
    this.iconSize = 40,
    this.radius = 0,
  });

  final ProductCategory category;
  final double height;
  final double? width;
  final double iconSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            category.color,
            Color.lerp(category.color, Colors.black, 0.3)!,
          ],
        ),
      ),
      child: Icon(category.icon, size: iconSize, color: Colors.white),
    );
  }
}
