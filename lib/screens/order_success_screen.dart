import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/nav_controller.dart';
import '../providers/order_provider.dart';
import '../utils/format.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.orderId});

  final String orderId;

  void _backToTab(BuildContext context, int tab) {
    Navigator.of(context).popUntil((r) => r.isFirst);
    context.read<NavController>().go(tab);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final order = context.read<OrderProvider>().byId(orderId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Dibuat'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text('Terima kasih!', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  order == null
                      ? 'Pesanan berhasil dibuat.'
                      : 'Pesanan ${order.id} senilai ${formatRupiah(order.total)} '
                          'sedang diproses.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _backToTab(context, NavController.orders),
                    child: const Text('Lihat Pesanan'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _backToTab(context, NavController.catalog),
                    child: const Text('Kembali ke Katalog'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
