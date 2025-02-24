import 'package:dio/dio.dart';
import 'package:rcs_portal_eaze/base/preferences.dart';
import 'api_service.dart';

var apiInterceptor = QueuedInterceptorsWrapper(
  onRequest: (options, handler) async {
    if (options.path == '/login') {
      return handler.next(options);
    }

    String token = await Preferences().getToken();

    if (token.isEmpty || token == '') {
      var resultToken = await PortalEazeApiService().login();
      token = resultToken.data?.token ?? '';
      Preferences().saveToken(token);
    }
    options.headers['Content-Type'] = "application/json";
    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  },
  onError: (e, handler) {
    return handler.next(e);
  },
  onResponse: (e, handler) {
    return handler.next(e);
  },
);
