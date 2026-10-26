import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/catalog_provider.dart';
import '../providers/nav_controller.dart';
import '../utils/format.dart';
import '../widgets/cover_art.dart';
import '../widgets/quantity_stepper.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Product? _product;
  int _qty = 0;

  @override
  void initState() {
    super.initState();
    _product = context.read<CatalogProvider>().byId(widget.productId);
    _qty = _product?.minOrderKg ?? 0;
  }

  void _addToCart(Product product) {
    context.read<CartProvider>().add(product, _qty);
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('$_qty kg ${product.name} masuk keranjang'),
        action: SnackBarAction(
          label: 'Lihat Keranjang',
          onPressed: () {
            Navigator.of(context).popUntil((r) => r.isFirst);
            context.read<NavController>().go(NavController.cart);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = _product;
    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Produk')),
        body: const Center(child: Text('Produk tidak ditemukan.')),
      );
    }

    final theme = Theme.of(context);

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.category.label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 4),
        Text(product.name, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.place_outlined, size: 18),
            const SizedBox(width: 4),
            Expanded(child: Text(product.origin)),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '${formatRupiah(product.pricePerKg)} / kg',
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 4),
        Text(
          'Minimal order ${product.minOrderKg} kg · Stok ${product.stockKg} kg',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final n in product.flavorNotes) Chip(label: Text(n)),
          ],
        ),
        const SizedBox(height: 12),
        Text(product.description, style: theme.textTheme.bodyMedium),
      ],
    );

    final buy = Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jumlah pesanan', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            QuantityStepper(
              value: _qty,
              min: product.minOrderKg,
              max: product.stockKg,
              onChanged: (v) => setState(() => _qty = v),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text(
                  formatRupiah(product.pricePerKg * _qty),
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _addToCart(product),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Tambah ke Keranjang'),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, box) {
                  final twoColumns = box.maxWidth >= 640;
                  final cover = CoverArt(
                    category: product.category,
                    height: twoColumns ? 280 : 180,
                    iconSize: 72,
                    radius: 16,
                  );
                  if (twoColumns) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: cover),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [info, const SizedBox(height: 16), buy],
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cover,
                      const SizedBox(height: 16),
                      info,
                      const SizedBox(height: 16),
                      buy,
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
