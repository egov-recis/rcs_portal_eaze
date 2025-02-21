import 'package:flutter/material.dart';
import 'strings.dart';

TextStyle textH1({Color? color}) {
  return TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textH2({Color? color}) {
  return TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textH3({Color? color}) {
  return TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textH4({Color? color}) {
  return TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textH5({Color? color}) {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textH6({Color? color}) {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textH7({Color? color}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textSub1({Color? color}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textSub2({Color? color}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textSub2Underlined({Color? color}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
    decoration: TextDecoration.underline,
  );
}

TextStyle textBody1({Color? color}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textBody2({Color? color}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textBody2Underlined({Color? color}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
    decoration: TextDecoration.underline,
  );
}

TextStyle textCaption({Color? color}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textCaption2({Color? color}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textCaption2Underlined({Color? color}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
    decoration: TextDecoration.underline,
    decorationColor: color ?? Colors.black,
  );
}

TextStyle textOverline({Color? color}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    wordSpacing: 1.2,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textButtonLg({Color? color}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textButtonMd({Color? color}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textButtonSm({Color? color}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.black,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textError() {
  return const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.red,
    fontFamily: Strings.fontFamily,
  );
}

TextStyle textCustom({
  double? size,
  Color? color,
  FontWeight? weight,
  bool? underline,
  bool? italic,
}) {
  return TextStyle(
    fontSize: size,
    color: color ?? Colors.black,
    fontWeight: weight,
    fontFamily: Strings.fontFamily,
    fontStyle: italic == true ? FontStyle.italic : FontStyle.normal,
    decoration: underline == true ? TextDecoration.underline : null,
    decorationColor: underline == true ? (color ?? Colors.black) : null,
  );
}
