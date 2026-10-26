import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/nav_controller.dart';
import 'cart_screen.dart';
import 'catalog_screen.dart';
import 'orders_screen.dart';

/// Kerangka navigasi utama. Layar sempit memakai NavigationBar di bawah,
/// layar lebar (tablet/landscape/web) memakai NavigationRail di samping.
class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  static const double wideBreakpoint = 720;
  static const List<Widget> _pages = [
    CatalogScreen(),
    CartScreen(),
    OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavController>();
    final cartCount = context.select<CartProvider, int>((c) => c.itemCount);
    final isWide = MediaQuery.of(context).size.width >= wideBreakpoint;

    Widget cartIcon(bool selected) => Badge(
          isLabelVisible: cartCount > 0,
          label: Text('$cartCount'),
          child: Icon(
            selected ? Icons.shopping_cart : Icons.shopping_cart_outlined,
          ),
        );

    final body = IndexedStack(index: nav.index, children: _pages);

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                selectedIndex: nav.index,
                onDestinationSelected: nav.go,
                labelType: NavigationRailLabelType.all,
                destinations: [
                  const NavigationRailDestination(
                    icon: Icon(Icons.storefront_outlined),
                    selectedIcon: Icon(Icons.storefront),
                    label: Text('Katalog'),
                  ),
                  NavigationRailDestination(
                    icon: cartIcon(false),
                    selectedIcon: cartIcon(true),
                    label: const Text('Keranjang'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.receipt_long_outlined),
                    selectedIcon: Icon(Icons.receipt_long),
                    label: Text('Pesanan'),
                  ),
                ],
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: nav.index,
        onDestinationSelected: nav.go,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Katalog',
          ),
          NavigationDestination(
            icon: cartIcon(false),
            selectedIcon: cartIcon(true),
            label: 'Keranjang',
          ),
          const NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pesanan',
          ),
        ],
      ),
    );
  }
}
