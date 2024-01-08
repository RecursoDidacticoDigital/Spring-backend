import 'dart:convert';

class ClassroomsResponses {
    List<Salones> salones;
    Salon? salon;

    ClassroomsResponses({
        required this.salones,
        this.salon,
    });

    factory ClassroomsResponses.fromJson(String str) => ClassroomsResponses.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory ClassroomsResponses.fromMap(Map<String, dynamic> json) => ClassroomsResponses(
        salones: List<Salones>.from(json["Salones"].map((x) => Salones.fromMap(x))),
        salon: Salon.fromMap(json["Salon"]),
    );

    Map<String, dynamic> toMap() => {
        "Salones": List<dynamic>.from(salones.map((x) => x.toMap())),
        "Salon": salon!.toMap(),
    };
}

class Salones {
    int id;
    String number;
    String name;
    int subjects;
    int building;

    Salones({
        required this.id,
        required this.number,
        required this.name,
        required this.subjects,
        required this.building,
    });

    factory Salones.fromJson(String str) => Salones.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory Salones.fromMap(Map<String, dynamic> json) => Salones(
        id: json["id"],
        number: json["number"],
        name: json["name"],
        subjects: json["subjects"],
        building: json["building"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "number": number,
        "name": name,
        "subjects": subjects,
        "building": building,
    };

    @override
    String toString(){
    return 'Salon: $name';
    }
}

class Salon {
    int id;
    String number;
    String name;
    int subjects;
    int building;

    Salon({
        required this.id,
        required this.number,
        required this.name,
        required this.subjects,
        required this.building,
    });

    factory Salon.fromJson(String str) => Salon.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory Salon.fromMap(Map<String, dynamic> json) => Salon(
        id: json["id"],
        number: json["number"],
        name: json["name"],
        subjects: json["subjects"],
        building: json["building"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "number": number,
        "name": name,
        "subjects": subjects,
        "building": building,
    };
}