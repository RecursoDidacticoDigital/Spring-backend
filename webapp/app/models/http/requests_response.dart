import 'dart:convert';

class Request {
    int id;
    String memberName;
    String memberAccount;
    String department;
    int? classroomId;
    String classroom;
    int day;
    int timeblock;
    String subject;
    int approved;

    Request({
        required this.id,
        required this.memberName,
        required this.memberAccount,
        required this.department,
        this.classroomId,
        required this.classroom,
        required this.day,
        required this.timeblock,
        required this.subject,
        required this.approved,
    });

    factory Request.fromJson(String str) => Request.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory Request.fromMap(Map<String, dynamic> json) => Request(
        id: json["id"],
        memberName: json["username"],
        memberAccount: json["useraccount"],
        department: json["department"],
        classroomId: json["classroomid"],
        classroom: json["classroom"],
        day: json["dayid"],
        timeblock: json["timeblockid"],
        subject: json["subject"],
        approved: json["approved"]
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "username": memberName,
        "useraccount": memberAccount,
        "department": department,
        "classroomid": classroomId,
        "classroom": classroom,
        "dayid": day,
        "timeblockid": timeblock,
        "subject": subject,
        "approved": approved,
    };
}

class RequestsResponse {
    List<Request> requests;

    RequestsResponse({required this.requests});

    factory RequestsResponse.fromJson(String str) => RequestsResponse.fromList(json.decode(str));

    factory RequestsResponse.fromList(List<dynamic> list) => 
        RequestsResponse(requests: list.map((x) => Request.fromMap(x)).toList());
}

