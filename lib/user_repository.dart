import 'dart:async';
import 'dart:convert';
import 'package:GTNexpress/constants.dart';
import 'package:GTNexpress/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:GTNexpress/model/api_model.dart';
import 'package:GTNexpress/api_connection/api_connection.dart';
import 'package:GTNexpress/dao/user_dao.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final userDao = UserDao();
  int dt_now_in_second = DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;

  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);

    //START GET ROLES FROM SERVER
    String id = "0";
    String roles = "0";
    String appid = "0";
    String organizationid = "";
    String name = "Guest..";
    // print("CHECK AKINO ROLES token: ${token.token}");
    Map<String,String> headers = {'Content-Type':'application/json','Authorization': 'Bearer ${token.token}','Tenant' :'pna'};
    final response = await http.get( Uri.parse("https://gtnexpress.vn/api/get_roles"),headers: headers);
    // print(response.body.toString());
    if (response.statusCode == 200) {
      final String stringBody = response.body;
      var jsonBody = json.decode(stringBody);
      // print(response.body.toString());
      globals["id"] = jsonBody["id"].toString();
      globals["appid"] = jsonBody["id"].toString();
      globals["name"] = jsonBody["name"].toString();
      id = jsonBody["id"].toString();
      roles = jsonBody["roles"].toString();
      name = jsonBody["name"].toString();
      appid = jsonBody["id"].toString();
    } else {
      id = "0";
      roles = "0";
      name = "Guest";
      appid = "0";
    }
    //END GET ROLES FROM SERVER
    User user = User(
        id: 0,
        username: username,
        name: name,
        token: token.token,
        roles: roles,
        password: password,
        appid: appid,
        organizationid:organizationid.toString(),
        exp: (dt_now_in_second + 144000)
    );
    return user;
  }

  Future<void> persistToken({@required User user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future<void> deleteToken({@required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}
