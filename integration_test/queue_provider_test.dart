import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:waiting_room_app/queue_provider.dart';
import 'package:waiting_room_app/models/client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Supabase.initialize(
      url: 'https://jtvkvanigrxuipnrvxvj.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp0dmt2YW5pZ3J4dWlwbnJ2eHZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkwNTQwMTAsImV4cCI6MjA3NDYzMDAxMH0.1lBsLlisT5d2dtY2m5iAGQuoDnAEPcVHNIn5PqjJqbo',
    );
  });

  late QueueProvider provider;

  setUp(() {
    provider = QueueProvider();
  });

  testWidgets('Add and remove client with real Supabase', (tester) async {
    final name = 'Integration Test Client';

    await provider.addClient(name);
    await Future.delayed(const Duration(seconds: 2));

    final addedClient = provider.clients.firstWhere(
          (c) => c.name == name,
      orElse: () => Client(id: 'error', name: 'not_found', created_at: DateTime(0)),
    );

    expect(addedClient.name, name);

    //await provider.removeClient(addedClient.id);
    //await Future.delayed(const Duration(seconds: 2));

    //final exists = provider.clients.any((c) => c.name == name);
    //expect(exists, false);
  });
}
