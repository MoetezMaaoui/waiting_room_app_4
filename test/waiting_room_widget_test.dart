import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:waiting_room_app/main.dart';
import 'package:waiting_room_app/queue_provider.dart';

void main() {
  testWidgets('should remove the first client from the list when "Next Client" is tapped',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => QueueProvider(),
            child: const WaitingRoomApp(),
          ),
        );

        // Add Client A
        await tester.enterText(find.byType(TextField), 'Client A');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Add Client B
        await tester.enterText(find.byType(TextField), 'Client B');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Tap Next Client
        await tester.tap(find.byKey(const Key('nextClientButton')));
        await tester.pump();

        // Verify
        expect(find.text('Client A'), findsNothing);
        expect(find.text('Client B'), findsOneWidget);
        expect(find.text('Clients in Queue: 1'), findsOneWidget);
      });
}
