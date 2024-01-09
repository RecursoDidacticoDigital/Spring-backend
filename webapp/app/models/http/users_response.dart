import 'dart:convert';

class UsersResponse {
    List<Usuarios> usuarios;

    UsersResponse({
        required this.usuarios,
    });

    factory UsersResponse.fromJson(String str) => UsersResponse.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        usuarios: List<Usuarios>.from(json["Usuario"].map((x) => Usuarios.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "Usuario": List<dynamic>.from(usuarios.map((x) => x.toMap())),
    };
}

class Usuarios {
  int userId;
  String userName;
  String userAccount;
  String userEmail;
  String userPassword;
  String userRole;

  Usuarios({
      required this.userId,
      required this.userName,
      required this.userAccount,
      required this.userEmail,
      required this.userPassword,
      required this.userRole,
  });

  factory Usuarios.fromJson(String str) => Usuarios.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuarios.fromMap(Map<String, dynamic> json) => Usuarios(
      userId: json["id"],
      userName: json["name"],
      userAccount: json["account"],
      userEmail: json["email"],
      userPassword: json["password"],
      userRole: json["user_rol"],
  );

  Map<String, dynamic> toMap() => {
      "id": userId,
      "name": userName,
      "account": userAccount,
      "email": userEmail,
      "password": userPassword,
      "rol": userRole,
  };

  @override
  String toString(){
    return 'Usuario: $userName';
  }
}
