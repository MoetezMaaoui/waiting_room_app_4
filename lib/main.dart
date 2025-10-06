/*import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'queue_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabaseUrl = 'https://jtvkvanigrxuipnrvxvj.supabase.co';
  final supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp0dmt2YW5pZ3J4dWlwbnJ2eHZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkwNTQwMTAsImV4cCI6MjA3NDYzMDAxMH0.1lBsLlisT5d2dtY2m5iAGQuoDnAEPcVHNIn5PqjJqbo';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );



  // Auth anonyme
  await Supabase.instance.client.auth.signInAnonymously();

  runApp(
    ChangeNotifierProvider(
      create: (context) => QueueProvider(),
      child: const WaitingRoomApp(),
    ),
  );
}

class WaitingRoomApp extends StatelessWidget {
  const WaitingRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waiting Room',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Waiting Room')),
        body: const WaitingRoomScreen(),
      ),
    );
  }
}

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QueueProvider>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Enter name'),
                  onSubmitted: (name) {
                    provider.addClient(name);
                    _controller.clear();
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  provider.addClient(_controller.text);
                  _controller.clear();
                },
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: provider.clients.isEmpty
                ? const Center(child: Text('No one in queue yet...'))
                : ListView.builder(
              itemCount: provider.clients.length,
              itemBuilder: (context, index) {
                final client = provider.clients[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(client.name),
                    subtitle: Text(client.created_at.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => provider.removeClient(client.id),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => provider.nextClient(),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next Client'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'queue_provider.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final supabaseUrl = dotenv.env['SUPABASE_URL']!;
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;


  try {
    final result = await InternetAddress.lookup('jtvkvanigrxuipnrvxvj.supabase.co');
    print('Résultat DNS: $result');
  } catch (e) {
    print('Impossible de résoudre l’hôte: $e');
  }


  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  // Anonymous sign in
  try {
    final authResponse = await Supabase.instance.client.auth.signInAnonymously();
    if (authResponse.user == null) {
      throw Exception('Failed to sign in anonymously');
    }
  } catch (e) {
    throw Exception('Auth error: $e');
  }


  runApp(
    ChangeNotifierProvider(
      create: (_) => QueueProvider(),
      child: const WaitingRoomApp(),
    ),
  );
}

class WaitingRoomApp extends StatelessWidget {
  const WaitingRoomApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waiting Room',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WaitingRoomPage(),
    );
  }
}

class WaitingRoomPage extends StatefulWidget {
  const WaitingRoomPage({super.key});
  @override
  State<WaitingRoomPage> createState() => _WaitingRoomPageState();
}

class _WaitingRoomPageState extends State<WaitingRoomPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QueueProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Waiting Room')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
        Row(children: [
        Expanded(
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter name'),
          onSubmitted: (v) {
            context.read<QueueProvider>().addClient(v);
            _controller.clear();
          },
        ),
      ),
      const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              final name = _controller.text;
              context.read<QueueProvider>().addClient(name);
              _controller.clear();
            },
            child: const Text('Add'),
          ),
          ]),
      const SizedBox(height: 20),
      Expanded(
        child: provider.clients.isEmpty
            ? const Center(child: Text('No one in queue yet...'))
            : ListView.builder(
          itemCount: provider.clients.length,
          itemBuilder: (context, i) {
            final c = provider.clients[i];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(c.name),
                subtitle: Text(c.created_at.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => context.read<QueueProvider>().removeClient(c.id),
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 12),
      ElevatedButton.icon(
        onPressed: () => context.read<QueueProvider>().nextClient(),
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Next Client'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      ),
      ],
    ),
    ),
    );
  }
}
