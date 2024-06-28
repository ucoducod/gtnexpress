// class User {
//   int id;
//   String username;
//   String token;
//
//   User({this.id, this.username, this.token});
//
//   factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
//         id: data['id'],
//         username: data['username'],
//         token: data['token'],
//       );
//
//   Map<String, dynamic> toDatabaseJson() =>
//       {"id": id, "username": username, "token": token};
// }
class User {
  int id;
  String username;
  String name;
  String token;
  String roles;
  String password;
  String appid;
  int exp;
  String organizationid;

  User({this.id, this.username,this.name, this.token, this.exp, this.roles, this.password,this.appid,this.organizationid,});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
    id: data['id'],
    username: data['username'],
    name: data['name'],
    token: data['token'],
    exp: data['exp'],
    roles: data['roles'],
    password: data['password'],
    organizationid:data['organizationid'],
    appid: data['appid'],
  );

  Map<String, dynamic> toDatabaseJson() =>
      {"id": id, "name": name,"username": username, "token": token, "exp": exp,"roles": roles,"password": password,"appid": appid,"organizationid": organizationid,};
}
