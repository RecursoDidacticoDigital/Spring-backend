import 'dart:convert';

class Subject {
    int id;
    String? group;
    String name;
    String classroom;
    String? teacher;
    String? laboratory;
    int dayid1;
    int dayid2;
    int dayid3;
    int dayid4;
    int dayid5;
    int timeblockid1;
    int timeblockid2;
    int timeblockid3;
    int timeblockid4;
    int timeblockid5;

    Subject({
        required this.id,
        this.group,
        required this.name,
        required this.classroom,
        this.teacher,
        this.laboratory,
        required this.dayid1,
        required this.dayid2,
        required this.dayid3,
        required this.dayid4,
        required this.dayid5,
        required this.timeblockid1,
        required this.timeblockid2,
        required this.timeblockid3,
        required this.timeblockid4,
        required this.timeblockid5,
    });

    factory Subject.fromJson(String str) => Subject.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory Subject.fromMap(Map<String, dynamic> json) => Subject(
        id: json["id"] as int,
        group: json["group"] as String?,
        name: json["name"] as String,
        classroom: json["classroom"] as String,
        teacher: json["teacher"] as String?,
        laboratory: json["laboratory"] as String?,
        dayid1: json["dayid1"] as int,
        dayid2: json["dayid2"] as int,
        dayid3: json["dayid3"] as int,
        dayid4: json["dayid4"] as int,
        dayid5: json["dayid5"] as int,
        timeblockid1: json["timeblockid1"] as int,
        timeblockid2: json["timeblockid2"] as int,
        timeblockid3: json["timeblockid3"] as int,
        timeblockid4: json["timeblockid4"] as int,
        timeblockid5: json["timeblockid5"] as int,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "group": group,
        "name": name,
        "classroom": classroom,
        "teacher": teacher,
        "laboratory": laboratory,
        "dayid1": dayid1,
        "dayid2": dayid2,
        "dayid3": dayid3,
        "dayid4": dayid4,
        "dayid5": dayid5,
        "timeblockid1": timeblockid1,
        "timeblockid2": timeblockid2,
        "timeblockid3": timeblockid3,
        "timeblockid4": timeblockid4,
        "timeblockid5": timeblockid5,
    };
}

class SubjectsResponse {
    List<Subject> subjects;

    SubjectsResponse({required this.subjects});

    factory SubjectsResponse.fromJson(String str) => SubjectsResponse.fromList(json.decode(str));

    factory SubjectsResponse.fromList(List<dynamic> list) => 
        SubjectsResponse(subjects: list.map((x) => Subject.fromMap(x)).toList());
}

