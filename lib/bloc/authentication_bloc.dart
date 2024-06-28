import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:GTNexpress/user_repository.dart';
import 'package:GTNexpress/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

import '../constants.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required this.userRepository})
      : assert(UserRepository != null),
        super(AuthenticationUnauthenticated());

  final UserRepository userRepository;
  final storage = const FlutterSecureStorage();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      // yield AuthenticationLoading();//dau cham nam o day remove thissssssssssssss
      await userRepository.persistToken(user: event.user);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      // yield AuthenticationLoading();
      final cookieManager = CookieManager();
      cookieManager.clearCookies();
      await storage.deleteAll();
      await userRepository.deleteToken(id: 0);
      globals = {
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
      // globals["id"]="0";
      // globals["roles"]="0";
      // globals["username"]="guest";
      // globals["name"]="Guest";
      // globals["token"]="TNA";
      // globals["password"]="PWD";
      // globals["appid"]="0";
      // globals["organizationid"]="null";
      // globals["startdatekh"]=null;
      // globals["enddatekh"]=null;
      // globals["startdatexk"]=null;
      // globals["enddatexk"]=null;
      // globals["startdatehh"]=null;
      // globals["enddatehh"]=null;
      // globals["searchproduct"]=null;
      // globals["searchproductsg"]=null;
      // globals["comissionstatus"]=null;
      // globals["moi_tao"] = globals["dang_nhan"] = globals["da_nhan"] = null;

      // "moi_tao":null,
      // "dang_nhan":null,
      // "da_nhan":null,
      // "dang_giao":null,
      // "cho_giao_lai":null,
      // "da_giao":null,
      // "cho_tra":null,//dang_tra sai => cho_tra
      // "da_tra":null,
      // "cho_chuyen_cod":null,
      // "da_chuyen_cod":null,
      // "hoan_tat":null,//
      // "luu_kho":null,
      // "ship_chua_thanh_toan":null,
      // "ship_da_thanh_toan":null,
      //
      // "tong_don_hang":null,
      // "tong_cuoc":null,
      // "tong_thu_cod":null,
      // "tong_tra_cod":null,
      // "tong_cho_tra_cod":null,
      // "dang_giao_cod":null
      yield AuthenticationUnauthenticated();
    }
  }
}
