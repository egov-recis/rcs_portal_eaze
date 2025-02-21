import 'package:flutter_test/flutter_test.dart';
import 'package:rcs_portal_eaze/rcs_portal_eaze.dart';
import 'package:rcs_portal_eaze/rcs_portal_eaze_platform_interface.dart';
import 'package:rcs_portal_eaze/rcs_portal_eaze_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRcsPortalEazePlatform
    with MockPlatformInterfaceMixin
    implements RcsPortalEazePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RcsPortalEazePlatform initialPlatform = RcsPortalEazePlatform.instance;

  test('$MethodChannelRcsPortalEaze is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRcsPortalEaze>());
  });

  test('getPlatformVersion', () async {
    RcsPortalEaze rcsPortalEazePlugin = RcsPortalEaze();
    MockRcsPortalEazePlatform fakePlatform = MockRcsPortalEazePlatform();
    RcsPortalEazePlatform.instance = fakePlatform;

    expect(await rcsPortalEazePlugin.getPlatformVersion(), '42');
  });
}
