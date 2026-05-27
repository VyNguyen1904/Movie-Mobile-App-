import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_5/screens/watchlist_screen.dart';

void main() {
  testWidgets('full watchlist flow: add, edit, save', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WatchlistScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Add item
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Movie / TV Show Title'),
      'Original title',
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Note'),
      'Original note',
    );

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Original title'), findsOneWidget);

    // Edit item
    await tester.tap(find.byIcon(Icons.edit).first);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Movie / TV Show Title'),
      'Updated title',
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Note'),
      'Updated note',
    );

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Updated title'), findsOneWidget);
    expect(find.text('Updated note'), findsOneWidget);
  });
}