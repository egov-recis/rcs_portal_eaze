import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:rcs_portal_eaze/common/text.dart';

class RealtimeFirebase {
  Query reference(String ref) {
    var url =
        "https://recis-smartonbill-default-rtdb.asia-southeast1.firebasedatabase.app/";
    print(ref);
    var instance =
        FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: url)
            .ref(ref);
    return instance;
    // return FirebaseDatabase.instance.ref();
    // return firebaseDatabase.refFromURL(ref);
  }

  addChat(String ref, Map value) async {
    DatabaseReference database = FirebaseDatabase.instance.ref(ref);
    // .push();
    await database.set(value);
    // firebaseDatabase.refFromURL("$referenceUrl/$ref").set(value).asStream();
  }

  removeRef(String ref) async {
    var url =
        "https://recis-smartonbill-default-rtdb.asia-southeast1.firebasedatabase.app/";
    DatabaseReference database =
        FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: url)
            .ref(ref);
    await database.remove();
  }
}

String formattingRp(String text) {
  String result = "";
  int dot = text.length ~/ 3;
  int extend = text.length % 3;
  int position = 0;
  for (var i = 0; i <= dot; i++) {
    if (i == 0) {
      result += text.substring(0, extend);
      position = extend;
    } else {
      if (extend == 0) {
        result += text.substring(position, position + 3);
        extend = 1;
      } else {
        result += ".${text.substring(position, position + 3)}";
      }
      position += 3;
    }
  }
  return result;
}

int differenceTime(DateTime timeTarget) {
  final now = DateTime.now();
  final difference = timeTarget.difference(now).inSeconds;
  return difference;
}

String timeLeft(int seconds) {
  int diff = seconds;

  int hours = diff ~/ (60 * 60);
  diff -= hours * (60 * 60);
  int minutes = diff ~/ (60);
  diff -= minutes * (60);

  String result =
      "${twoDigitNumber(hours)}:${twoDigitNumber(minutes)}:${twoDigitNumber(diff)}";

  return result;
}

String twoDigitNumber(int? dateTimeNumber) {
  if (dateTimeNumber == null) return "0";
  return (dateTimeNumber < 10 ? "0$dateTimeNumber" : dateTimeNumber).toString();
}

void showSnackbar({required String title, required String body}) {
  Get.snackbar(title, body);
}

class RupiahInputFormatter extends TextInputFormatter {
  RupiahInputFormatter({this.symbol});

  String? symbol;
  String? _unmaskedText;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // No need to remove period instead use
    // WhitelistingTextInputFormatter.digitsOnly
    // _unmaskedText = newValue.text.replaceAll(RegExp(r'[^\d+]'), '');
    _unmaskedText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double? parsed = double.tryParse(_unmaskedText ?? '0');

    String formatted = NumberFormat.currency(
      locale: 'id',
      symbol: symbol ?? '',
      decimalDigits: 0,
    ).format(parsed);

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String get unmaskedText => _unmaskedText.toString();

  static String unformatted(String text) {
    return text.replaceAll(RegExp(r'[^\d+]'), '');
  }
}

Map<String, int> getLengthAvailableMenu(int lengthMenu) {
  var expand = 0;
  var result = 0;
  if (lengthMenu <= 4) {
    result = lengthMenu;
  } else if (lengthMenu > 4 && lengthMenu < 8) {
    expand = 1;
    result = 4;
  } else if (lengthMenu == 8) {
    result = 8;
  } else {
    expand = 1;
    result = 8;
  }
  return {
    'result': result,
    'expand': expand,
  };
}

sheetError({
  required BuildContext context,
  required int typeError,
  String? msg,
}) {
  showSheetCustom(
    context: context,
    content: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 2,
            width: 24,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: AspectRatio(
              aspectRatio: 3,
              child: Image.asset(
                typeError == 500
                    ? 'assets/images/error_code_500.png'
                    : 'assets/images/error_code_400.png',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              msg ?? 'Terjadi Kesalahan',
              style: textBody2(),
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Strings.primaryColor,
              ),
              child: Center(
                child: Text(
                  'OK',
                  style: textSub2(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

showSheetCustom({
  required BuildContext context,
  required Widget content,
  Widget? title,
  bool? cancelable,
  bool? isMax,
  bool? isPaddingHorizontal,
  bool? isTitle,
}) {
  showModalBottomSheet(
    isDismissible: cancelable == true ? true : false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: isTitle == true
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: isPaddingHorizontal == false ? 0 : 8,
                    ),
                    child: title ?? const Text('Custom Title'),
                  ),
                  Expanded(
                    // height: MediaQuery.of(context).size.height * 0.8,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          top: isTitle == true ? 0 : 16,
                          bottom: 16,
                          left: isPaddingHorizontal == false ? 0 : 8,
                          right: isPaddingHorizontal == false ? 0 : 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: isMax == true
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                          children: [
                            content,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              height: isMax == true
                  ? MediaQuery.of(context).size.height * 0.8
                  : null,
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: isTitle == true ? 0 : 16,
                    bottom: 16,
                    left: isPaddingHorizontal == false ? 0 : 8,
                    right: isPaddingHorizontal == false ? 0 : 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize:
                        isMax == true ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      content,
                    ],
                  ),
                ),
              ),
            ),
    ),
  );
}
