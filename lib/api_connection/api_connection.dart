import 'dart:async';
import 'dart:convert';
import 'package:GTNexpress/constants.dart';
import 'package:http/http.dart' as http;
import 'package:GTNexpress/model/api_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:GTNexpress/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// const _base = "https://gtnexpress.vn/api";
// const _tokenEndpoint = "/tokens";
// const _tokenURL = _base + _tokenEndpoint;

const storage = FlutterSecureStorage();
Future<Token> getToken(UserLogin userLogin) async {
  // var client = http.Client();
  String uname = userLogin.username;
  String upass = userLogin.password;
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$uname:$upass'));

  try {
    final http.Response response = await http.post('https://gtnexpress.vn/api/tokens',headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode != 200) {
      // print("not json: ${response.statusCode}");
      return null;
    } else {
      if (response.statusCode == 200) {
        String tokensave = Token.fromJson(json.decode(response.body)).token.toString();
        String namesave = json.decode(response.body)["name"].toString();
        String rolessave = json.decode(response.body)["roles"].toString();
        String idsave = json.decode(response.body)["id"].toString();
        print(json.decode(response.body));
        // print(namesave);
        // print(rolessave);
        await storage.write(key: "storagetoken", value: tokensave);
        await storage.write(key: "appusername", value: uname);
        await storage.write(key: "apppassword", value: upass);
        await storage.write(key: "appname", value: namesave);
        await storage.write(key: "appid", value: idsave);
        await storage.write(key: "roles", value: json.decode(response.body)["roles"]);
        globals["name"] = namesave;
        globals["roles"] = rolessave;
        globals["id"] = idsave;
        int dt_now = DateTime.now().millisecondsSinceEpoch;
        int dt_now_in_second = dt_now ~/ Duration.millisecondsPerSecond;
        dt_now_in_second = dt_now_in_second + 144000;//exp in 40 hour
        await storage.write(key: "exp", value: "${dt_now_in_second}" );
        // print(json.decode(response.body));
        return Token.fromJson(json.decode(response.body));
      } else {
        throw Exception("!=200 error:");
      }
    }
  } on Exception catch (exception) {
    // only executed if error is of type Exception
    // print("exception error: ${exception}");
    throw Exception("exception error: ${exception}");
  } catch (e) {
    // print("catch error: ${e}");
    throw Exception("catch error: ${e}");
    return null;
  }
}
