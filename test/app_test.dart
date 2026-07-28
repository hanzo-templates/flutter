import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzo_flutter/data.dart';
import 'package:hanzo_flutter/main.dart';

void main() {
  testWidgets('feed lists every item and opens one', (tester) async {
    await tester.pumpWidget(const HanzoApp());
    expect(find.text(items.first.title), findsOneWidget);

    await tester.tap(find.text(items.first.title));
    await tester.pumpAndSettle();
    expect(find.text(items.first.body), findsOneWidget);
  });

  testWidgets('search filters the list', (tester) async {
    await tester.pumpWidget(const HanzoApp());
    await tester.tap(find.byIcon(Icons.search_outlined));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(SearchBar), 'impeller');
    await tester.pumpAndSettle();
    expect(find.text(items[1].title), findsOneWidget);
    expect(find.text(items[0].title), findsNothing);
  });
}
