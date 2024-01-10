import 'package:meta/meta.dart';
import 'dart:convert';
// TODO: Terminar de adaptar a la api
class AuthResponses {
    String jwt;
    String role;
    dynamic errorMessage;
    User user;

    AuthResponses({
        required this.jwt,
        required this.role,
        required this.errorMessage,
        required this.user,
    });

    factory AuthResponses.fromJson(String str) => AuthResponses.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponses.fromMap(Map<String, dynamic> json) => AuthResponses(
        jwt: json["jwt"],
        role: json["role"],
        errorMessage: json["errorMessage"],
        user: User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "jwt": jwt,
        "role": role,
        "errorMessage": errorMessage,
        "user": user.toMap(),
    };
}

class User {
    int id;
    String username;
    String email;
    String provider;
    bool confirmed;
    bool blocked;
    DateTime createdAt;
    DateTime updatedAt;
    int tenantId;
    String tenantRole;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.provider,
        required this.confirmed,
        required this.blocked,
        required this.createdAt,
        required this.updatedAt,
        required this.tenantId,
        required this.tenantRole,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        tenantId: json["tenantId"],
        tenantRole: json["tenantRole"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "tenantId": tenantId,
        "tenantRole": tenantRole,
    };
}
