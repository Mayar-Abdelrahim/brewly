import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brewly/main.dart';

void main() {
  testWidgets('Product details total updates and order dialog shows', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Caramel Latte'), findsOneWidget);
    expect(find.text('Add to Cart · 80 EGP'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Add to Cart · 160 EGP'), findsOneWidget);

    await tester.tap(find.text('Add to Cart · 160 EGP'));
    await tester.pumpAndSettle();

    expect(find.text('Order Placed!'), findsOneWidget);
    expect(find.text('160 EGP'), findsOneWidget);
    expect(find.text('Back to Home'), findsOneWidget);
  });
}
