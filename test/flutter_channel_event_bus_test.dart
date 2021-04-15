import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_channel_event_bus/flutter_channel_event_bus.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_channel_event_bus');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterChannelEventBus.platformVersion, '42');
  });
}
