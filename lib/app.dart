import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/in_memory_order_repository.dart';
import 'data/in_memory_product_repository.dart';
import 'providers/cart_provider.dart';
import 'providers/catalog_provider.dart';
import 'providers/nav_controller.dart';
import 'providers/order_provider.dart';
import 'screens/home_shell.dart';

class CoffeeSupplyApp extends StatelessWidget {
  const CoffeeSupplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavController>(create: (_) => NavController()),
        ChangeNotifierProvider<CatalogProvider>(
          create: (_) => CatalogProvider(InMemoryProductRepository()),
        ),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<OrderProvider>(
          create: (_) => OrderProvider(InMemoryOrderRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Coffee Supply Platform',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6F4E37)),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
        home: const HomeShell(),
      ),
    );
  }
}
