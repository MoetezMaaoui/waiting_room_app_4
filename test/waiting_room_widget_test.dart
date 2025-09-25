import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waiting_room_app/main.dart';

void main() {
  testWidgets('should add a new client to the list on button tap', (WidgetTester tester) async {
    await tester.pumpWidget(const WaitingRoomApp());

    await tester.enterText(find.byType(TextField), 'Alice');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    //expect(find.text('Alice'), findsOneWidget);
    //expect(find.text('Clients in Queue: 1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('Alice'), findsNothing);
    expect(find.text('Clients in Queue: 0'), findsOneWidget);

  });
}
