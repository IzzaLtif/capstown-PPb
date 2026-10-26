import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../utils/format.dart';
import '../widgets/status_chip.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final order = context.read<OrderProvider>().byId(orderId);
    final theme = Theme.of(context);

    if (order == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Pesanan')),
        body: const Center(child: Text('Pesanan tidak ditemukan.')),
      );
    }

    Widget row(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(label, style: theme.textTheme.bodySmall),
              ),
              Expanded(child: Text(value)),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(title: Text(order.id)),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          formatDateTime(order.createdAt),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      StatusChip(status: order.status),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Item', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          for (final i in order.items)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${i.product.name} × ${i.qtyKg} kg',
                                    ),
                                  ),
                                  Text(formatRupiah(i.subtotal)),
                                ],
                              ),
                            ),
                          const Divider(),
                          Row(
                            children: [
                              const Expanded(child: Text('Total')),
                              Text(
                                formatRupiah(order.total),
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Pengiriman & pembayaran',
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  row('Pemesan', order.buyerName),
                  row('Usaha', order.businessName),
                  row('Telepon', order.phone),
                  row('Alamat', order.address),
                  row('Pembayaran', order.paymentMethod),
                  if (order.note.isNotEmpty) row('Catatan', order.note),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
