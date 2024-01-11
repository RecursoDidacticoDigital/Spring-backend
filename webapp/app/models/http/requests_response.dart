import 'dart:convert';

class Request {
    int id;
  String memberName;
  String memberAccount;
  String department;
  int classroomId;
  String day;
  int timeblock;
  String subject;
  bool? approved;

    Request({
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

    factory Request.fromJson(String str) => Request.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory Request.fromMap(Map<String, dynamic> json) => Request(
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
}

class RequestsResponse {
    List<Request> requests;

    RequestsResponse({required this.requests});

    factory RequestsResponse.fromJson(String str) => RequestsResponse.fromList(json.decode(str));

    factory RequestsResponse.fromList(List<dynamic> list) => 
        RequestsResponse(requests: list.map((x) => Request.fromMap(x)).toList());
}

