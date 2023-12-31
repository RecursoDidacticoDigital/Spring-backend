import 'dart:convert';

class SubjectsResponse {
    List<Materias> materias;

    SubjectsResponse({
        required this.materias,
    });

    factory SubjectsResponse.fromJson(String str) => SubjectsResponse.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory SubjectsResponse.fromMap(Map<String, dynamic> json) => SubjectsResponse(
        materias: List<Materias>.from(json["subject"].map((x) => Materias.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "subject": List<dynamic>.from(materias.map((x) => x.toMap())),
    };
}

class Materias {
    int id;
    String? group;
    String name;
    String classroom;
    String teacher;
    String? laboratory;
    int dayId1;
    int dayId2;
    int dayId3;
    int dayId4;
    int dayId5;
    int timeblockId1;
    int timeblockId2;
    int timeblockId3;
    int timeblockId4;
    int timeblockId5;

    Materias({
        required this.id,
        this.group,
        required this.name,
        required this.classroom,
        required this.teacher,
        this.laboratory,
        required this.dayId1,
        required this.dayId2,
        required this.dayId3,
        required this.dayId4,
        required this.dayId5,
        required this.timeblockId1,
        required this.timeblockId2,
        required this.timeblockId3,
        required this.timeblockId4,
        required this.timeblockId5,
    });

    factory Materias.fromJson(String str) => Materias.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory Materias.fromMap(Map<String, dynamic> json) => Materias(
        id: json["id"],
        group: json["group"],
        name: json["name"],
        classroom: json["classroom"],
        teacher: json["teacher"],
        laboratory: json["laboratory"],
        dayId1: json["day_id1"],
        dayId2: json["day_id2"],
        dayId3: json["day_id3"],
        dayId4: json["day_id4"],
        dayId5: json["day_id5"],
        timeblockId1: json["timeblock_id1"],
        timeblockId2: json["timeblock_id2"],
        timeblockId3: json["timeblock_id3"],
        timeblockId4: json["timeblock_id4"],
        timeblockId5: json["timeblock_id5"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "group": group,
        "name": name,
        "classroom": classroom,
        "teacher": teacher,
        "laboratory": laboratory,
        "day_id1": dayId1,
        "day_id2": dayId2,
        "day_id3": dayId3,
        "day_id4": dayId4,
        "day_id5": dayId5,
        "timeblock_id1": timeblockId1,
        "timeblock_id2": timeblockId2,
        "timeblock_id3": timeblockId3,
        "timeblock_id4": timeblockId4,
        "timeblock_id5": timeblockId5,
    };

    @override
    String toString(){
    return 'Materia: $name';
  }
}
