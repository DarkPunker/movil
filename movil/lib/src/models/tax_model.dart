class Taxes {
  List<Tax> items = new List();

  Taxes();

  Taxes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final tax = new Tax.fromJsonMap(item);
      items.add(tax);
    }
  }
}

class Tax {
  int id;
  String name;
  dynamic percentage;
  bool state;

  Tax({
    this.id,
    this.name,
    this.percentage,
    this.state,
  });

  Tax.fromJsonMap(Map<String, dynamic> json) {
    id = json['idTax'];
    name = json['taxName'];
    percentage = json['percentage'];
    state = json['isActive'];
  }
}
