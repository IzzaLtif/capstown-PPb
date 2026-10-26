import 'package:flutter/material.dart';

/// Pengatur jumlah (kg) dengan tombol kurang/tambah.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.step = 5,
  });

  final int value;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          tooltip: 'Kurangi',
          icon: const Icon(Icons.remove),
          onPressed: value > min
              ? () => onChanged((value - step).clamp(min, max).toInt())
              : null,
        ),
        SizedBox(
          width: 64,
          child: Text(
            '$value kg',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton.outlined(
          tooltip: 'Tambah',
          icon: const Icon(Icons.add),
          onPressed: value < max
              ? () => onChanged((value + step).clamp(min, max).toInt())
              : null,
        ),
      ],
    );
  }
}
