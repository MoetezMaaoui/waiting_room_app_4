
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'queue_provider.dart';

class QueueProvider extends ChangeNotifier {
  final List<String> _clients = [];
  List<String> get clients => _clients;

  void addClient(String name) {
    _clients.add(name);
    notifyListeners();
  }

  void removeClient(String name) {
    _clients.remove(name);
    notifyListeners();
  }

  void nextClient() {
    if (_clients.isNotEmpty) {
      _clients.removeAt(0);
      notifyListeners();
    }
  }
}

