class UnitesMeasurement {
  List<UnitMeasurement> items = new List();

  UnitesMeasurement();

  UnitesMeasurement.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final unit = new UnitMeasurement.fromJsonMap(item);
      items.add(unit);
    }
  }
}

class UnitMeasurement {
  int id;
  String name;
  String symbol;
  String unit;
  String type;

  UnitMeasurement({
    this.id,
    this.name,
    this.symbol,
    this.unit,
    this.type,
  });

  UnitMeasurement.fromJsonMap(Map<String, dynamic> json) {
    id = json['idUnitMeasurement'];
    name = json['unitMeasurementName'];
    symbol = json['symbol'];
    unit = json['typeUni'];
    type = json['type'];
  }
}
