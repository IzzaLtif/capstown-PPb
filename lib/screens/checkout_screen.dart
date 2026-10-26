import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../utils/format.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const _paymentMethods = ['Transfer Bank', 'Termin 14 Hari'];

  final _formKey = GlobalKey<FormState>();
  final _buyerCtrl = TextEditingController();
  final _businessCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String _payment = _paymentMethods.first;

  @override
  void dispose() {
    _buyerCtrl.dispose();
    _businessCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  String? _required(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? '$label wajib diisi' : null;

  String? _validatePhone(String? v) {
    final digits = (v ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 9) return 'Nomor telepon minimal 9 digit';
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final cart = context.read<CartProvider>();
    if (cart.isEmpty) return;

    final order = context.read<OrderProvider>().placeOrder(
          items: cart.items,
          buyerName: _buyerCtrl.text.trim(),
          businessName: _businessCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
          address: _addressCtrl.text.trim(),
          note: _noteCtrl.text.trim(),
          paymentMethod: _payment,
        );
    cart.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => OrderSuccessScreen(orderId: order.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ringkasan pesanan', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          for (final i in cart.items)
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
                                formatRupiah(cart.total),
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
                  Text('Data pemesan', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _buyerCtrl,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(labelText: 'Nama pemesan'),
                          validator: (v) => _required(v, 'Nama pemesan'),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _businessCtrl,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Nama usaha (kafe / roastery / toko)',
                          ),
                          validator: (v) => _required(v, 'Nama usaha'),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'No. telepon / WhatsApp',
                          ),
                          validator: _validatePhone,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _addressCtrl,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Alamat pengiriman',
                          ),
                          validator: (v) => _required(v, 'Alamat pengiriman'),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: _payment,
                          decoration: const InputDecoration(
                            labelText: 'Metode pembayaran',
                          ),
                          items: [
                            for (final m in _paymentMethods)
                              DropdownMenuItem(value: m, child: Text(m)),
                          ],
                          onChanged: (v) {
                            if (v != null) setState(() => _payment = v);
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _noteCtrl,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Catatan (opsional)',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: cart.isEmpty ? null : _submit,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text('Buat Pesanan'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
