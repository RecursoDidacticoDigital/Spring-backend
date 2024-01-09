import 'dart:convert';

class RequestsResponse {
    List<Solicitudes> solicitudes;

    RequestsResponse({
        required this.solicitudes,
    });

    factory RequestsResponse.fromJson(String str) => RequestsResponse.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory RequestsResponse.fromMap(Map<String, dynamic> json) => RequestsResponse(
        solicitudes: List<Solicitudes>.from(json["Solicitud"].map((x) => Solicitudes.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "Solicitud": List<dynamic>.from(solicitudes.map((x) => x.toMap())),
    };
}

class Solicitudes {
  int id;
  String memberName;
  String memberAccount;
  String department;
  int classroomId;
  String day;
  int timeblock;
  String subject;
  bool? approved;

  Solicitudes({
      required this.id,
      required this.memberName,
      required this.memberAccount,
      required this.department,
      required this.classroomId,
      required this.day,
      required this.timeblock,
      required this.subject,
      this.approved,
  });

  factory Solicitudes.fromJson(String str) => Solicitudes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Solicitudes.fromMap(Map<String, dynamic> json) => Solicitudes(
      id: json["id"],
      memberName: json["member_name"],
      memberAccount: json["member_account"],
      department: json["department"],
      classroomId: json["classroom_id"],
      day: json["day_id"],
      timeblock: json["timeblock_id"],
      subject: json["subject"],
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "member_name": memberName,
      "member_account": memberAccount,
      "department": department,
      "classroom_id": classroomId,
      "day_id": day,
      "timeblock_id": timeblock,
      "subject": subject,
  };

  @override
  String toString(){
    return 'Solicitud: $memberName';
  }
}
