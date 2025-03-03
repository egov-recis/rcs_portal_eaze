import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rcs_portal_eaze/base/api_interceptor.dart';
import 'package:rcs_portal_eaze/base/preferences.dart';
import 'package:rcs_portal_eaze/model/news.dart';
import 'package:rcs_portal_eaze/model/payment_group.dart';
import 'package:rcs_portal_eaze/model/payment_type.dart';
import 'package:rcs_portal_eaze/model/payment_type_group.dart';
import 'package:rcs_portal_eaze/model/request/postdata.dart';
import 'package:rcs_portal_eaze/model/response/api_response.dart';
import 'package:rcs_portal_eaze/model/response/api_response_list.dart';
import 'package:rcs_portal_eaze/model/response/response_denom.dart';
import 'package:rcs_portal_eaze/model/response/response_payment_category.dart';
import 'package:rcs_portal_eaze/model/response/response_payment_history.dart';
import 'package:rcs_portal_eaze/model/response/response_payment_qr.dart';
import 'package:rcs_portal_eaze/model/response/response_payment_type.dart';
import 'package:rcs_portal_eaze/model/response/response_transaction_track.dart';
import 'package:rcs_portal_eaze/model/result_data.dart';
import 'package:rcs_portal_eaze/model/server_error.dart';
import 'package:rcs_portal_eaze/model/token.dart';
import 'package:rcs_portal_eaze/model/tracking.dart';
import 'package:rcs_portal_eaze/model/virtual_account.dart';

class PortalEazeApiService {
  PortalEazeApiService() {
    client = Dio();
    clientToken = Dio();

    cancelToken = CancelToken();
    client.options = BaseOptions(
      baseUrl: "http://103.182.72.242:8089/api/",
      // baseUrl: "https://eaze-dev.onbilling.id/api/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      // contentType: "application/json",
      contentType: "text/plain",
    );
    clientToken.options = BaseOptions(
      baseUrl: "http://103.182.72.242:8089/api/",
      // baseUrl: "https://eaze-dev.onbilling.id/api/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      // contentType: "application/json",
      // contentType: "text/plain",
    );
    client.interceptors.add(apiInterceptor);
    clientToken.interceptors.add(apiInterceptorToken);
  }

  late Dio client;
  late Dio clientToken;
  late CancelToken cancelToken;

  Future<ResultData<T>> getRequestData<T>(
    String path,
    T Function(dynamic data) builder,
  ) async {
    dynamic response;
    if (cancelToken == CancelToken()) {
      cancelToken.cancel();
    }
    cancelToken = CancelToken();
    try {
      var result = await client.get(
        path,
        cancelToken: cancelToken,
      );
      response = result.data;
    } on DioException catch (error) {
      if (error.response?.data != null) {
        response = error.response?.data;
      } else {
        return ResultData()
          ..setException(ServerError().withError(error: error));
      }
    }
    return ResultData()..setData(response, builder);
  }

  Future<ResultData<T>> getRequestListData<T>(
    String path,
    T Function(List<dynamic>? data) builder,
  ) async {
    dynamic response;
    if (cancelToken == CancelToken()) {
      cancelToken.cancel();
    }
    cancelToken = CancelToken();
    try {
      var result = await client.get(
        path,
        cancelToken: cancelToken,
      );
      response = result.data;
    } on DioException catch (error) {
      if (error.response?.data != null) {
        response = error.response?.data;
      } else {
        return ResultData()
          ..setException(ServerError().withError(error: error));
      }
    }
    return ResultData()..setDataList(response, builder);
  }

  Future<ApiResponse<T>> postRequestWithData<T>(
    String path,
    Map<String, dynamic>? request,
    T Function(Map<String, dynamic> data) builder,
  ) async {
    cancelToken = CancelToken();
    Map response;
    try {
      var result =
          await client.post(path, data: request, cancelToken: cancelToken);
      response = result.data;
    } on DioException catch (error) {
      ApiResponse data = ApiResponse.fromJson(
        error.response?.data,
        (p0) {},
      );
      return ApiResponse(
        code: data.code,
        message: data.message,
      );
      // print(error.response?.statusCode);
      // if (error.response?.data != null) {
      //   response = jsonDecode(error.response?.data);
      // } else {
      //   return ApiResponse()
      //     ..setException(ServerError().withError(error: error));
      // }
    }
    return ApiResponse()..setData(response, builder);
  }

  Future<ApiResponse<T>> getRequestWithoutData<T>(
    String path,
    T Function(Map<String, dynamic> data) builder,
  ) async {
    cancelToken = CancelToken();
    Map response;
    try {
      var result = await client.get(path, cancelToken: cancelToken);
      // response = jsonDecode(result.data);
      response = result.data;
    } on DioException catch (error) {
      return ApiResponse(
        code: error.response?.statusCode,
        message: error.response?.statusMessage,
      );
      // if (error.response?.data != null) {
      //   response = jsonDecode(error.response?.data);
      // } else {
      //   return ApiResponse()
      //     ..setException(ServerError().withError(error: error));
      // }
    }
    return ApiResponse()..setData(response, builder);
  }

  Future<ApiResponseList<T>> getRequestListWithoutData<T>(
    String path,
    List<T> Function(List<dynamic> data) builder,
  ) async {
    cancelToken = CancelToken();
    Map response;
    try {
      var result = await client.get(path, cancelToken: cancelToken);
      // response = jsonDecode(result.data);
      response = result.data;
    } on DioException catch (error) {
      return ApiResponseList(
        code: error.response?.statusCode,
        message: error.response?.statusMessage,
      );
      // if (error.response?.data != null) {
      //   response = jsonDecode(error.response?.data);
      // } else {
      //   return ApiResponseList()
      //     ..setException(ServerError().withError(error: error));
      // }
    }
    return ApiResponseList()..setData(response, builder);
  }

  Future<ApiResponse<T>> getRequestWithData<T>(
    String path,
    Map<String, dynamic> request,
    T Function(Map<String, dynamic> data) builder,
  ) async {
    cancelToken = CancelToken();
    Map response;
    try {
      var result =
          await client.get(path, data: request, cancelToken: cancelToken);
      response = jsonDecode(result.data);
    } on DioException catch (error) {
      if (error.response?.data != null) {
        response = jsonDecode(error.response?.data);
      } else {
        return ApiResponse(
          code: error.response?.statusCode,
          message: error.response?.statusMessage,
        );
        // return ApiResponse()
        //   ..setException(ServerError().withError(error: error));
      }
    }
    return ApiResponse()..setData(response, builder);
  }

  Future<ApiResponse<PaymentGroup>> paymentGroup() async {
    return await getRequestWithoutData(
      'v1/payment/group',
      (data) => PaymentGroup.fromJson(data),
    );
  }

  Future<ApiResponse<DenomResponse>> getDenom(String code) async {
    return await getRequestWithoutData(
      'v1/denom?code=$code',
      (data) => DenomResponse.fromJson(data),
    );
  }

  Future<ApiResponse<PaymentHistoryResponse>> getHistory(
    String partnerId, {
    String? limit,
    String? flag,
  }) async {
    var url =
        'v1/payment/history?access_key=c30caeb0cf25&filter[partner_id]=$partnerId';
    if (limit != null) {
      url += '&limit=$limit';
    }
    if (flag != null) {
      url += '&filter[flag]=$flag';
    }
    return await getRequestWithoutData(
      url,
      (data) => PaymentHistoryResponse.fromJson(data),
    );
  }

  Future<ApiResponse<Tracking>> tracking(PostData postData) async {
    return await postRequestWithData(
      'payment/tracking/client-refnum',
      postData.toMapTracking(),
      (data) => Tracking.fromJson(data),
    );
  }

  Future<ApiResponseList<PaymentTypeGroup>> getPaymentTypeGroup(
    String id,
  ) async {
    return await getRequestListWithoutData(
      'v1/payment/type/group?group=$id',
      (data) {
        List<PaymentTypeGroup> list = [];
        for (var element in data) {
          list.add(PaymentTypeGroup.fromJson(element));
        }
        return list;
      },
    );
  }

  Future<ApiResponse<TransactionTrackResponse>> transactionTrack(
    PostData postData,
  ) async {
    return await postRequestWithData(
      'v1/payment/transaction/track',
      postData.toMapTransactionTrack(),
      (data) => TransactionTrackResponse.fromJson(data),
    );
  }

  Future<ApiResponse<New>> getNews() async {
    ApiResponse<New> response = ApiResponse<New>();
    try {
      var result = await client.get(
        "v1/news?limit=5",
      );
      Map<String, dynamic> map = jsonDecode(result.data.toString());
      response = ApiResponse<New>.fromJson(map, (data) => New.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        Map<String, dynamic>? map = jsonDecode(error.response.toString());
        response = ApiResponse<New>.fromJson(
          map ?? {},
          (data) => New.fromJson(data),
        );
      }
    }
    return response;
  }

  Future<ApiResponse<PaymentTypes>> getPaymentType({int? page}) async {
    ApiResponse<PaymentTypes> response = ApiResponse<PaymentTypes>();
    page ??= 1;
    try {
      var result = await client.get(
        "v1/payment/type?limit=100&page=$page",
      );
      Map<String, dynamic> map = jsonDecode(result.data.toString());
      response = ApiResponse<PaymentTypes>.fromJson(
          map, (data) => PaymentTypes.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        Map<String, dynamic>? map = jsonDecode(error.response.toString());
        response = ApiResponse<PaymentTypes>.fromJson(
          map ?? {},
          (data) => PaymentTypes.fromJson(data),
        );
      }
    }
    return response;
  }

  Future<ResponsePaymentCategory> getPaymentCategory() async {
    ResponsePaymentCategory response = ResponsePaymentCategory();
    try {
      var result = await client.get(
        "v1/payment/category",
      );
      Map<String, dynamic> map = jsonDecode(result.data.toString());
      response = ResponsePaymentCategory.fromJson(map);
      return response;
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        if (error.response == null) {
          response = ResponsePaymentCategory(
            data: ResPaymentCategory(
              paymentCategory: [],
            ),
          );
        } else {
          Map<String, dynamic>? map = jsonDecode(error.response.toString());
          response = ResponsePaymentCategory.fromJson(map ?? {});
        }
      }
    }
    return response;
  }

  Future<ResponsePaymentType> getPaymentTypeByCategory(
    String category,
    String limit,
    String search,
  ) async {
    ResponsePaymentType response = ResponsePaymentType();
    try {
      var result = await client.get(
        "v1/payment/type/$category/category?limit=$limit&srch=$search",
      );
      Map<String, dynamic> map = jsonDecode(result.data.toString());
      response = ResponsePaymentType.fromJson(map);
      return response;
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        Map<String, dynamic>? map = jsonDecode(error.response.toString());
        response = ResponsePaymentType.fromJson(map ?? {});
      }
    }
    return response;
  }

  Future<ResponsePaymentType> getPaymentTypeAdditionalLimit(
      String limit) async {
    ResponsePaymentType response = ResponsePaymentType();
    try {
      var result = await client.get(
        "v1/payment/type?limit=$limit",
      );
      Map<String, dynamic> map = jsonDecode(result.data.toString());
      response = ResponsePaymentType.fromJson(map);
      return response;
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        Map<String, dynamic>? map = jsonDecode(error.response.toString());
        response = ResponsePaymentType.fromJson(map ?? {});
      }
    }
    return response;
  }

  Future<ResponsePaymentType> getPaymentTypeAdditionalKey(String type) async {
    ResponsePaymentType response = ResponsePaymentType();
    try {
      var result = await client.get(
        "v1/payment/type?limit=10&srch=$type",
      );
      Map<String, dynamic> map = jsonDecode(result.data.toString());
      response = ResponsePaymentType.fromJson(map);
      return response;
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        if (error.response == null) {
          response = ResponsePaymentType(
            data: ResPaymentType(
              paymentType: [],
            ),
          );
        } else {
          Map<String, dynamic>? map = jsonDecode(error.response.toString());
          response = ResponsePaymentType.fromJson(map ?? {});
        }
      }
    }
    return response;
  }

  Future<ResponsePaymentType> getPaymentTypeAdditionalLimitAndKey(
      String limit, String type) async {
    ResponsePaymentType response = ResponsePaymentType();
    try {
      var result = await client.get(
        "v1/payment/type?limit=$limit&srch=$type",
      );
      Map<String, dynamic> map = jsonDecode(result.data.toString());
      response = ResponsePaymentType.fromJson(map);
      return response;
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        Map<String, dynamic>? map = jsonDecode(error.response.toString());
        response = ResponsePaymentType.fromJson(map ?? {});
      }
    }
    return response;
  }

  Future<ApiResponse<VirtualAccount>> payment(
    Map<String, dynamic> request,
  ) async {
    return await postRequestWithData(
      'v1/payment/generate',
      request,
      (data) {
        return VirtualAccount.fromJson(data);
      },
    );
  }

  Future<ResponsePaymentQr> paymentQR(
    String idBilling,
    String paymentType,
    String amount,
  ) async {
    ResponsePaymentQr response = ResponsePaymentQr();
    try {
      Map<String, dynamic> request = {};
      request['id_billing'] = idBilling;
      request['payment_type'] = paymentType;
      request['payment_method'] = "1";
      request['trx_amount'] = amount;
      var result = await client.post(
        "v1/payment/generate",
        data: jsonEncode(request),
      );
      Map<String, dynamic> map = jsonDecode(result.data.toString());
      response = ResponsePaymentQr.fromJson(map);
      return response;
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        Map<String, dynamic>? map = jsonDecode(error.response.toString());
        response = ResponsePaymentQr.fromJson(map ?? {});
      }
    }
    return response;
  }

  // Future<ApiResponse<Token>> login() async {
  //   ApiResponse<Token> response = ApiResponse<Token>();
  //   try {
  //     var result = await clientToken.post(
  //       "login",
  //       data: {
  //         "email": "mobile_app1@mail.com",
  //         "password": "mobileapp1",
  //       },
  //     );
  //     response = ApiResponse<Token>.fromJson(
  //       result.data,
  //       (data) => Token.fromJson(data),
  //     );
  //     print("login: ${response.data?.token}");
  //     Preferences().saveToken(response.data?.token);
  //   } catch (e) {
  //     print("login: $e");
  //     if (e is DioException) {
  //       DioException error = e;
  //       Map<String, dynamic>? map = jsonDecode(error.response.toString());
  //       response = ApiResponse<Token>.fromJson(
  //         map ?? {},
  //         (data) => Token.fromJson(data),
  //       );
  //     }
  //   }
  //   return response;
  // }

  Future<ApiResponse<Token>> platform() async {
    ApiResponse<Token> response = ApiResponse<Token>();
    try {
      var result = await clientToken.post(
        "access/platform",
        data: {
          "access_key": "4a44a80ebe75",
        },
      );
      response = ApiResponse<Token>.fromJson(
        result.data,
        (data) => Token.fromJson(data),
      );
      Preferences().saveToken(jsonEncode(response.data?.toJson()));
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        Map<String, dynamic>? map = jsonDecode(error.response.toString());
        response = ApiResponse<Token>.fromJson(
          map ?? {},
          (data) => Token.fromJson(data),
        );
      }
    }
    return response;
  }
}
