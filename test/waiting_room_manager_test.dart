import 'package:flutter_test/flutter_test.dart';
import 'package:waiting_room_app/queue_provider.dart';

void main() {
  test('should remove the first client when nextClient() is called', () {
    final manager = QueueProvider();
    manager.addClient('Client A');
    manager.addClient('Client B');

    manager.nextClient();

    expect(manager.clients.length, 1);
    expect(manager.clients.first, 'Client B');
  });
}
