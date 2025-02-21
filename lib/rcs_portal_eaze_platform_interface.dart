import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rcs_portal_eaze_method_channel.dart';

abstract class RcsPortalEazePlatform extends PlatformInterface {
  /// Constructs a RcsPortalEazePlatform.
  RcsPortalEazePlatform() : super(token: _token);

  static final Object _token = Object();

  static RcsPortalEazePlatform _instance = MethodChannelRcsPortalEaze();

  /// The default instance of [RcsPortalEazePlatform] to use.
  ///
  /// Defaults to [MethodChannelRcsPortalEaze].
  static RcsPortalEazePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RcsPortalEazePlatform] when
  /// they register themselves.
  static set instance(RcsPortalEazePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
