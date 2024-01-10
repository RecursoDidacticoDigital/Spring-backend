import 'package:meta/meta.dart';
import 'dart:convert';

class User {
    int id;
    String name;
    String email;
    String account;
    String password;
    String rol;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.account,
        required this.password,
        required this.rol,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        account: json["account"],
        password: json["password"],
        rol: json["rol"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "account": account,
        "password": password,
        "rol": rol,
    };
}

class UsersResponse {
    List<User> users;

    UsersResponse({required this.users});

    factory UsersResponse.fromJson(String str) => UsersResponse.fromList(json.decode(str));

    factory UsersResponse.fromList(List<dynamic> list) => 
        UsersResponse(users: list.map((x) => User.fromMap(x)).toList());
}

