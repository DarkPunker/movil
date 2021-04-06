import 'dart:convert';

class Products {
  List<Product> items = new List();

  Products();

  Products.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final product = new Product.fromJsonMap(item);
      items.add(product);
    }
  }
}

Product productFromJson(String str) => Product.fromJsonMap(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int id;
  String code;
  String name;
  String description;
  String photoUrl;
  int value;
  bool state;
  List<dynamic> taxes;
  int idCompany;
  int idUnitMeasurement;

  Product({
    this.id,
    this.code = '',
    this.name = '',
    this.description = '',
    this.value = 0,
    this.state = true,
    this.taxes,
    this.idCompany,
    this.idUnitMeasurement,
    this.photoUrl,
  });

  factory Product.fromJsonMap(Map<String, dynamic> json) => Product(
        id: json["idProduct"],
        code: json["productCode"],
        name: json["productName"],
        description: json["description"],
        value: json["productValue"],
        state: json["isActive"],
        idCompany: json["idCompany"],
        idUnitMeasurement: json["idUnitMeasurement"],
        photoUrl: json["photoUrl"]
      );

  Map<String, dynamic> toJson() => {
        "idProduct": id,
        "productCode": code,
        "productName": name,
        "description": description,
        "productValue": value,
        "isActive": state,
        "idCompany": idCompany,
        "idUnitMeasurement": idUnitMeasurement,
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
        "photoUrl" : photoUrl,
      };
}
