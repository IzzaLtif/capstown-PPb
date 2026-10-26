import 'package:coffee_supply_platform/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('aplikasi menampilkan katalog saat dibuka', (tester) async {
    await tester.pumpWidget(const CoffeeSupplyApp());
    expect(find.text('Katalog Kopi'), findsWidgets);
    expect(find.text('Arabika Gayo'), findsWidgets);
  });
}
