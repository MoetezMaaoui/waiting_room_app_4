import 'package:flutter/cupertino.dart';

class Client {
  final String id;
  final String name;
  final DateTime created_at;

  Client({
    required this.id,
    required this.name,
    required this.created_at,
  });

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      name: map['name'],
      created_at: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': created_at.toIso8601String(),
    };
  }

  @override
  String toString() => 'Client(id: $id, name: $name, created_at: $created_at)';
}
