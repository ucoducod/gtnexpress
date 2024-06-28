// import 'package:flutter/material.dart';
//
// const primaryColor = Colors.blue;
// const secondaryColor = Color(0xFF2697FF);
// const bgColor = Colors.white;
//
// const defaultPadding = 8.0;

import 'package:flutter/material.dart';

// const primaryColor = Color(0xFF2697FF);
const primaryColor = Colors.indigo;
const secondaryColor = Color(0xFF2A2D3E);
// const bgColor = Color(0xFF212332);
const bgColor = Colors.white;

// const primaryColor = Colors.blue;
// const secondaryColor = Color(0xFF2697FF);
// const bgColor = Colors.white;

const defaultPadding = 8.0;

Map globals = {
  "id": "0",
  "roles": "0",
  "username": "guest",
  "name": "",
  "token":"TOKEN",
  "password":"PWD",
  "appid":"0",
  "organizationid":"null",
  "startdatekh":null,
  "enddatekh":null,
  "startdatexk":null,
  "enddatexk":null,
  "startdatehh":null,
  "enddatehh":null,
  "searchproduct":null,
  "searchproductsg":null,
  "comissionstatus":null,

  "moi_tao":null,
  "dang_nhan":null,
  "da_nhan":null,
  "dang_giao":null,
  "cho_giao_lai":null,
  "da_giao":null,
  "cho_tra":null,//dang_tra sai => cho_tra
  "da_tra":null,
  "cho_chuyen_cod":null,
  "da_chuyen_cod":null,
  "hoan_tat":null,//
  "luu_kho":null,
  "ship_chua_thanh_toan":null,
  "ship_da_thanh_toan":null,

  "tong_don_hang":null,
  "tong_cuoc":null,
  "tong_thu_cod":null,
  "tong_tra_cod":null,
  "tong_cho_tra_cod":null,
  "dang_giao_cod":null

  // if request_data['status'][3] == "true":#moi_tao
  // list_vandon_in.append(1)
  //   if request_data['status'][4] == "true":#da_nhan
  //   list_vandon_in.append(4)
  //     if request_data['status'][5] == "true":#dang_giao
  //     list_vandon_in.append(5)
  //       if request_data['status'][6] == "true":#cho_giao_lai#cho xu ly
  //       list_vandon_in.append(6)
  //         if request_data['status'][7] == "true":#da_giao
  //         list_vandon_in.append(7)
  //           if request_data['status'][8] == "true":#dang_tra
  //           list_vandon_in.append(8)
  //             if request_data['status'][9] == "true":#da_tra
  //             list_vandon_in.append(9)
  //               if request_data['status'][10] == "true":#cho_chuyen_cod
  //               list_vandon_in.append(10)
  //                 if request_data['status'][11] == "true":#da_chuyen_cod
  //                 list_vandon_in.append(11)
  //                   if request_data['status'][12] == "true":#luu_kho
  //                   list_vandon_in.append(13)


// if (text["Moi tao:"]?.toString() == "true"){
// globals["moi_tao"] = "true";
// }
// if (text["Da nhan"]?.toString() == "true"){
// globals["da_nhan"] = "true";
// }
// if (text["Dang giao"]?.toString() == "true"){
// globals["dang_giao"] = "true";
// }
// if (text["Cho giao lai"]?.toString() == "true"){
// globals["cho_giao_lai"] = "true";
// }
// if (text["Da giao"]?.toString() == "true"){
// globals["da_giao"] = "true";
// }
// if (text["Da tra"]?.toString() == "true"){
// globals["da_tra"] = "true";
// }
// if (text["Cho thanh toan"]?.toString() == "true"){
// globals["cho_chuyen_cod"] = "true";
// }
// if (text["Da thanh toan"]?.toString() == "true"){
// globals["da_chuyen_cod"] = "true";
// }
};

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle( // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle( // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle( // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle( // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle( // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle( // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

}

class FitnessAppTheme {
  FitnessAppTheme._();
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}

