import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rcs_portal_eaze/rcs_portal_eaze_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelRcsPortalEaze platform = MethodChannelRcsPortalEaze();
  const MethodChannel channel = MethodChannel('rcs_portal_eaze');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
