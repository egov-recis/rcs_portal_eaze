import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rcs_portal_eaze/base/preferences.dart';
import 'package:rcs_portal_eaze/model/token.dart';
import 'api_service.dart';

var apiInterceptor = QueuedInterceptorsWrapper(
  onRequest: (options, handler) async {
    print('path: ${options.path}');
    if (options.path == '/login') {
      return handler.next(options);
    }
    var stringToken = await Preferences().getToken();
    String token = Token.fromJson(jsonDecode(stringToken)).token ?? "";
    print('token: $token');

    if (token.isEmpty || token == '') {
      var resultToken = await PortalEazeApiService().platform();
      token = resultToken.data?.token ?? '';
      Preferences().saveToken(jsonEncode(resultToken.data?.toJson()));
    }
    options.headers['Content-Type'] = "application/json";
    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  },
  onError: (e, handler) {
    print(e.error);
    print(e.message);
    print(e.response);
    return handler.next(e);
  },
  onResponse: (e, handler) {
    return handler.next(e);
  },
);

var apiInterceptorToken = QueuedInterceptorsWrapper(
  onRequest: (options, handler) async {
    options.headers['Content-Type'] = "application/json";
    options.headers['Authorization'] =
        "Basic ${base64.encode(utf8.encode("portal-app:portal-app"))}";

    return handler.next(options);
  },
  onError: (e, handler) {
    return handler.next(e);
  },
  onResponse: (e, handler) {
    print('response_token: ${e.data}');
    return handler.next(e);
  },
);
