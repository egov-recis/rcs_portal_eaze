import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rcs_portal_eaze_platform_interface.dart';

/// An implementation of [RcsPortalEazePlatform] that uses method channels.
class MethodChannelRcsPortalEaze extends RcsPortalEazePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rcs_portal_eaze');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
