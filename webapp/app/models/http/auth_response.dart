import 'dart:convert';

class AuthResponses {
    Usuario usuario;
    String token;

    AuthResponses({
        required this.usuario,
        required this.token,
    });

    factory AuthResponses.fromJson(String str) => AuthResponses.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponses.fromMap(Map<String, dynamic> json) => AuthResponses(
        usuario: Usuario.fromMap(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "usuario": usuario.toMap(),
        "token": token,
    };
}

class Usuario {
    int userId;
    String userName;
    String userAccount;
    String userEmail;
    String userPassword;
    String userRole;

    Usuario({
        required this.userId,
        required this.userName,
        required this.userAccount,
        required this.userEmail,
        required this.userPassword,
        required this.userRole,
    });

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        userId: json["user_id"],
        userName: json["user_name"],
        userAccount: json["user_account"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
        userRole: json["user_role"],
    );

    Map<String, dynamic> toMap() => {
        "user_id": userId,
        "user_name": userName,
        "user_account": userAccount,
        "user_email": userEmail,
        "user_password": userPassword,
        "user_role": userRole,
    };
}
