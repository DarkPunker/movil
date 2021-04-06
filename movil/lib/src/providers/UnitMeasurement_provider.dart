import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movil/src/models/unit_measurement_model.dart';
import 'package:movil/src/providers/http_complements.dart';


class UnitMeasurementProvider {
  
  Future<List<UnitMeasurement>> getUnitMeasurement() async {
    final resp = await http.get(uriGetUnitMeasurement());
    final decodedData = json.decode(resp.body);
    final unit = new UnitesMeasurement.fromJsonList(decodedData);
    return unit.items;
  }
}