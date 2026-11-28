import 'package:flutter_test/flutter_test.dart';

import 'package:brewly/main.dart';

void main() {
  testWidgets('Onboarding shows and Get Started opens home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Fresh Coffee,\nMade for You'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Brewly!'), findsOneWidget);
  });
}
