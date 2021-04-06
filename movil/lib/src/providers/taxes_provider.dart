import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movil/src/models/tax_model.dart';
import 'package:movil/src/providers/http_complements.dart';



class TaxesProvider {
 

  Future<List<Tax>> getTaxes() async {
    final resp = await http.get(uriGetTaxes());
    final decodedData = json.decode(resp.body);
    final taxes = new Taxes.fromJsonList(decodedData);
    return taxes.items;
  }
}