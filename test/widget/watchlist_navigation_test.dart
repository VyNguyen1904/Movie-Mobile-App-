import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_5/screens/genre_screen.dart';

void main() {
  testWidgets('should navigate from movie list to movie detail screen',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: GenreScreen(),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Find a Movie'), findsOneWidget);

        await tester.tap(find.text('Dune: Part Two').first);
        await tester.pumpAndSettle();

        expect(find.text('Trailers'), findsOneWidget);
        expect(find.text('Favorite'), findsOneWidget);
      });
}