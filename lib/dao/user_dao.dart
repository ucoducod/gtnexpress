import 'package:GTNexpress/database/user_database.dart';
import 'package:GTNexpress/model/user_model.dart';

// class UserDao {
//   final dbProvider = DatabaseProvider.dbProvider;
//
//   Future<int> createUser(User user) async {
//     final db = await dbProvider.database;
//
//     var result = db.insert(userTable, user.toDatabaseJson());
//
//     return result;
//   }
//
//   Future<int> deleteUser(int id) async {
//     final db = await dbProvider.database;
//     var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
//     return result;
//   }
//
//   Future<bool> checkUser(int id) async {
//     final db = await dbProvider.database;
//     try {
//       List<Map> users =
//           await db.query(userTable, where: 'id = ?', whereArgs: [id]);
//       if (users.isNotEmpty) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (error) {
//       return false;
//     }
//   }
//
//   Future<String> getToken(int id) async {
//     final db = await dbProvider.database;
//     try {
//       List<Map> users =
//           await db.query(userTable, where: 'id = ?', whereArgs: [id]);
//       if (users.isNotEmpty) {
//         return users[0]["token"];
//       } else {
//         return "0";
//       }
//     } catch (error) {
//       return "1";
//     }
//   }
//   // Future<String> getUserToken(int id) async {
//   //   final db = await dbProvider.database;
//   //   try {
//   //     var res = await db.rawQuery("SELECT token FROM userTable WHERE id=0");
//   //     return res.isNotEmpty ? (User.fromDatabaseJson(res.first)).token : null;
//   //   } catch (err) {
//   //     return null;
//   //   }
//   // }
//
// }

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart';

import 'package:http/http.dart' as http;

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;
  final storage = const FlutterSecureStorage();

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());

    globals["id"] = user.appid;
    globals["roles"] = user.roles;
    globals["token"] = user.token;
    globals["username"] = user.username;
    globals["name"] = user.name;
    globals["password"] = user.password;
    globals["appid"] = user.appid;
    globals["organizationid"] = user.organizationid;

    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
      await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.isNotEmpty) {
        //Check Expired
        int dt_now = DateTime.now().millisecondsSinceEpoch;//1351441456747 [mili seconds]
        int dt_now_in_second = dt_now ~/ Duration.millisecondsPerSecond;//1351441456 [to seconds]
        print("user_dao checkUser app start ?${dt_now_in_second} < ${users[0]["exp"]} =>true not logout");
        // if (dt_now_in_second >= users[0]["exp"]) {
        //   await db.delete(userTable, where: "id = ?", whereArgs: [id]);
        //   await storage.deleteAll();
        //   print("checkUser: Success delete secure storage token");
        //
        //   globals["roles"]="0";
        //   globals["username"]="guest";
        //   globals["token"]="TNA";
        //   globals["password"]="PWD";
        //   globals["appid"]="appid";
        //   globals["organizationid"]="null";
        //   globals["startdatekh"]=null;
        //   globals["enddatekh"]=null;
        //   globals["startdatexk"]=null;
        //   globals["enddatexk"]=null;
        //   globals["startdatehh"]=null;
        //   globals["enddatehh"]=null;
        //   globals["searchproduct"]=null;
        //   globals["comissionstatus"]=null;
        //   return false;
        // }
        //Save Global
        globals["id"] = users[0]["appid"];
        globals["roles"] = users[0]["roles"];
        globals["token"] = users[0]["token"];
        globals["username"] = users[0]["username"];
        globals["name"] = users[0]["name"];
        globals["password"] = users[0]["password"];
        globals["appid"] = users[0]["appid"];
        globals["organizationid"] = users[0]["organizationid"];

        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('catch error dbProvider.database: ${error.toString()}');
      return false;
    }
  }

  Future<String> getToken(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
      await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.isNotEmpty) {
        int dt_now = DateTime.now().millisecondsSinceEpoch;//1351441456747 [mili seconds]
        int dt_now_in_second = dt_now ~/ Duration.millisecondsPerSecond;//1351441456 [to seconds]

        // if (dt_now_in_second >= users[0]["exp"]) {
        //   await db.delete(userTable, where: "id = ?", whereArgs: [id]);
        //   await storage.deleteAll();
        //   print("getToken: Success delete secure storage token");
        //   return "0";
        // }
        // globals["roles"] = users[0]["username"].contains("cskh")?"cskh":"daily";
        globals["id"] = users[0]["appid"];
        globals["roles"] = users[0]["roles"];
        globals["token"] = users[0]["token"];
        globals["username"] = users[0]["username"];
        globals["name"] = users[0]["name"];
        globals["password"] = users[0]["password"];
        globals["appid"] = users[0]["appid"];
        globals["organizationid"] = users[0]["organizationid"];

        return users[0]["token"];
      } else {
        return "000000000000000";
      }
    } catch (error) {
      return "1111111111111111";
    }
  }
// Future<String> getUserToken(int id) async {
//   final db = await dbProvider.database;
//   try {
//     var res = await db.rawQuery("SELECT token FROM userTable WHERE id=0");
//     return res.isNotEmpty ? (User.fromDatabaseJson(res.first)).token : null;
//   } catch (err) {
//     return null;
//   }
// }

}

