import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_5/screens/watchlist_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: WatchlistScreen(),
    );
  }

  testWidgets('should show empty state when no items exist', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('No saved items found'), findsOneWidget);
  });

  testWidgets('should open add dialog when FAB is tapped', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Add Watch Item'), findsOneWidget);
    expect(find.text('Movie / TV Show Title'), findsOneWidget);
    expect(find.text('Note'), findsOneWidget);
  });

  testWidgets('should add a watch item', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Movie / TV Show Title'),
      'Interstellar',
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Note'),
      'Watch again',
    );

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Interstellar'), findsOneWidget);
    expect(find.text('Watch again'), findsOneWidget);
  });
}