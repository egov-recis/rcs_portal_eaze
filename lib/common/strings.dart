import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Strings {
  static dynamic RC_SUCCESS = 200;
  static dynamic RC_NOT_FOUND = 404;
  static dynamic RC_UNAUTH = 401;

  // AKUN TESTING STAGING
  // PHONE: 08123761247121 | 813228886053 | 81322888618 | 85647129336 | 8158828400 | 85364627336 | 8098654456 | 846531227946 | 81322888002
  // EMAIL: mikomkz@gmail.com
  // PWD: verySecret@1

  // AKUN TESTING PROD
  // 81322888627 | 87877761961 | 812321123321 | 85157754181 | 81322880006 | 87946532164

  static const String env = 'stg'; // dev | stg | prd
  static const bool capturable = true;
  static const bool alice = false;
  static const String token = 'token';
  static const String fontFamily = 'Montserrat';
  static const String firstInstall = 'firstInstall';
  static const String themeMode = 'themeMode';
  static const String themeModeLight = 'themeModeLight';
  static const String themeModeDark = 'themeModeDark';
  static const String loggin = "loggin";
  static const String authToken = "tokenAuth";
  static const String timeAuth = "timeAuth";
  static const String phoneNumber = 'phoneNumber';
  static const String biometric = "biometric";
  static const String secretKey = "secretKey";
  static const String deviceId = "deviceId";
  static const String draftKyc = "draftKyc";
  static const String masterDataKyc = "masterDataKyc";
  static const String locale = "locale";
  static const int defaultOtp = 2;
  // 1: Email, 2: Phone(WA)
  static const bool hidePayment = true;

  static const String categoryArticleEducation = kDebugMode ? "1" : "23";
  // 23 (PRD) | 1 (STG)
  static const String categoryArticleInfomasi = kDebugMode ? "5" : "24";
  // 24 (PRD) | 5 (STG)
  static const String categoryArticlePaymentMethod = kDebugMode ? "17" : "29";
  // 29 (PRD) | 17 (STG)
  static const String categoryArticleTncKyc = kDebugMode ? "37" : "42";
  // 42 (PRD) | 37 (STG)
  static const String categoryArticleTncKycPdp = kDebugMode ? "37" : "52";
  // 42 (PRD) | 37 (STG)
  static const String categoryArticleTentang = "45";
  // 45 (PRD) |

  static const String docReferenceKtp = "KTP";
  static const String docReferenceSelfie = "selfie";
  static const String docReferenceNpwp = "ktp"; //npwp
  static const String docReferenceArticle = "article";
  static const String docReferenceSignature = "kTp"; //signature

  static const String routeMain = '/main';
  static const String routeIntro = '/intro';
  static const String routeLogin = '/login';
  static const String routeRegisterKYC = '/register_kyc';
  static const String routeOtp = '/otp';
  static const String routeRegister = '/register';
  static const String routeMaintenance = '/maintenance';

  static const int transactionTypeBuyOneTime = 1;
  static const int transactionTypeSubscription = 2;
  static const int transactionTypeTopUp = 0;
  static const int transactionTypeRedeem = 3;
  static const int transactionTypeSwitch = 4;

  static const String tab7InputText = 'tab_7_input_text';
  static const String tab7InputDoubleText = 'tab_7_input_double_text';
  static const String tab7InputOption = 'tab_7_input_option';
  static const String tab7InputFree = 'tab_7_input_free';

  static const String urlCloudStorage =
      "https://storage.googleapis.com/bahanalinkrcs/";

  static String urlImage = "${getBaseUrl()}/api/v1/public/tcw/asset/";

  static String homeRoute = "/home";
  static String paymentRoute = "/payment";
  static String paymentsRoute = "/payments";
  static String qrisRoute = "/qris";
  static String virtualAccountRoute = "/virtual_account";
  static String vaWebRoute = "/va_web";
  static String guideRoute = "/guide";
  static String newsRoute = "/news";
  static String trackingRoute = "/tracking";
  static String deepLinkRoute = "/deep_link";
  static String historyRoute = "/history";

  static String dbName = "portlet.db";
  // static String fontFamily = "Poppins";
  static String udid = "udid";
  // static String token = "token";

  static Color primaryColor = const Color(0xFF425BA7);

  static String getBaseUrl() {
    // if (kDebugMode) {
    //   // return "https://api-blink.bahanatcw.com";
    //   return "http://103.182.72.16:8003";
    // } else {
    //   return "https://api-blink.bahanatcw.com";
    // }
    var value = "";
    switch (env) {
      case 'dev':
        value = 'http://192.168.26.229:8003';
        break;
      case 'stg':
        value = 'http://103.182.72.16:8003';
        break;
      case 'prd':
        // value = 'https://34.8.194.27';
        value = 'https://api-blink.bahanatcw.com';
        // value = 'https://api-blink.bahanatcw.com';
        break;
      default:
        value = 'http://103.182.72.16:8003';
    }
    return value;
  }

  static String getBaseUrlArticle() {
    var value = '${getBaseUrl()}/api/v1/public/gcp/asset/';
    return value;
  }

  static String getStatusTransaction(String id) {
    var value = '';
    switch (id) {
      case '0':
        value = 'Pending';
        break;
      case '1':
        value = 'Recieved';
        break;
      case '2':
        value = 'Processed';
        break;
      case '3':
        value = 'In Progress';
        break;
      case '4':
        value = 'Successfull';
        break;
      case '5':
        value = 'Rejected';
        break;
      case '7':
        value = 'Close';
        break;
      case '41':
        value = 'Cleared';
        break;
      default:
    }
    return value;
  }
}
