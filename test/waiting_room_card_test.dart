// test/waiting_room_card_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:waiting_room_app/waiting_room_card.dart';

void main() {
  testWidgets('WaitingRoomCard displays the name correctly', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      const MaterialApp(
        home: WaitingRoomCard(name: 'Alice'),
      ),
    );

    // Vérifie que le texte "Hello," est présent
    expect(find.text('Hello,'), findsOneWidget);

    // Vérifie que le nom "Alice" est affiché
    expect(find.text('Alice'), findsOneWidget);
  });
}
