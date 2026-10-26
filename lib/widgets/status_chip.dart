import 'package:flutter/material.dart';

import '../models/order.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (Color bg, Color fg) = switch (status) {
      OrderStatus.processing => (
          scheme.secondaryContainer,
          scheme.onSecondaryContainer
        ),
      OrderStatus.shipped => (
          scheme.tertiaryContainer,
          scheme.onTertiaryContainer
        ),
      OrderStatus.completed => (
          scheme.primaryContainer,
          scheme.onPrimaryContainer
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.label,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
