import 'package:dio/dio.dart';
import 'package:rcs_portal_eaze/base/preferences.dart';
import 'api_service.dart';

var apiInterceptor = QueuedInterceptorsWrapper(
  onRequest: (options, handler) async {
    print('BASE URL: ${options.baseUrl}');
    print('PATH: ${options.path}');
    if (options.path == '/login') {
      return handler.next(options);
    }

    String token = await Preferences().getToken();
    print('TOKEN: $token');

    if (token.isEmpty || token == '') {
      var resultToken = await ApiService().login();
      token = resultToken.data?.token ?? '';
      Preferences().saveToken(token);
    }
    options.headers['Content-Type'] = "application/json";
    options.headers['Authorization'] = 'Bearer $token';

    print('BODY: ${options.data}');
    return handler.next(options);
  },
  onError: (e, handler) {
    print("[ERROR DATA] ${e.response?.data}");
    return handler.next(e);
  },
  onResponse: (e, handler) {
    print('RESPONSE: $e');
    return handler.next(e);
  },
);
