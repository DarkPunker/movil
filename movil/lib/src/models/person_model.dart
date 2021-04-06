import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
    Person({
        this.cc,
        this.name,
        this.lastname,
        this.email,
        this.addres,
        this.phone,
        this.birthDate,
        this.docExpeditionDate,
        this.idDocType,
    });

    String cc;
    String name;
    String lastname;
    String email;
    String addres;
    String phone;
    String birthDate;
    String docExpeditionDate;
    int idDocType;

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        cc: json["cc"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        addres: json["addres"],
        phone: json["phone"],
        birthDate: json["birthDate"],
        docExpeditionDate: json["docExpeditionDate"],
        idDocType: json["idDocType"],
    );

    Map<String, dynamic> toJson() => {
        "cc": cc,
        "name": name,
        "lastname": lastname,
        "email": email,
        "addres": addres,
        "phone": phone,
        "birthDate": birthDate,
        "docExpeditionDate": docExpeditionDate,
        "idDocType": idDocType,
    };
}
