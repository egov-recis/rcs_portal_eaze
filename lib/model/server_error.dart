import 'package:dio/dio.dart';

class ServerError implements Exception {
  late int _errorCode;
  late String _errorMessage = "";

  String withError({DioException? error}) {
    return _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioException? error) {
    switch (error?.type) {
      case DioExceptionType.badCertificate:
        _errorMessage =
            error?.message ?? "Bad certificate ${error?.response?.statusCode}";
        break;
      case DioExceptionType.badResponse:
        _errorMessage =
            error?.message ?? "Bad response ${error?.response?.statusCode}";
        break;
      case DioExceptionType.cancel:
        _errorMessage =
            error?.message ?? "Cancel ${error?.response?.statusCode}";
        break;
      case DioExceptionType.connectionError:
        _errorMessage =
            error?.message ?? "Connection error ${error?.response?.statusCode}";
        break;
      case DioExceptionType.connectionTimeout:
        _errorMessage = error?.message ??
            "Connection timeout ${error?.response?.statusCode}";
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage =
            error?.message ?? "Receive timeout ${error?.response?.statusCode}";
        break;
      case DioExceptionType.sendTimeout:
        _errorMessage =
            error?.message ?? "Send timeout ${error?.response?.statusCode}";
        break;
      case DioExceptionType.unknown:
        _errorMessage =
            error?.message ?? "Unknown error ${error?.response?.statusCode}";
        break;
      default:
        _errorMessage = "Undefined error ${error?.response?.statusCode}";
        break;
    }
    return _errorMessage;
  }
}
