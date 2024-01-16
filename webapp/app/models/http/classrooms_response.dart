import 'dart:convert';

class Classroom {
    int id;
    String number;
    String name;
    int subjects;
    int building;
    int queue;

    Classroom({
        required this.id,
        required this.number,
        required this.name,
        required this.subjects,
        required this.building,
        required this.queue
    });

    factory Classroom.fromJson(String str) => Classroom.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory Classroom.fromMap(Map<String, dynamic> json) => Classroom(
        id: json["id"],
        number: json["number"],
        name: json["name"],
        subjects: json["subjects"],
        building: json["building"],
        queue: json["queue"]
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "number": number,
        "name": name,
        "subjects": subjects,
        "building": building,
        "queue": queue
    };
}

class ClassroomsResponse {
    List<Classroom> classrooms;

    ClassroomsResponse({required this.classrooms});

    factory ClassroomsResponse.fromJson(String str) => ClassroomsResponse.fromList(json.decode(str));

    factory ClassroomsResponse.fromList(List<dynamic> list) => 
        ClassroomsResponse(classrooms: list.map((x) => Classroom.fromMap(x)).toList());
}

