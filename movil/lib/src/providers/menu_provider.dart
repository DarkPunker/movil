import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MenuProvider {
  List<dynamic> option = [];

  _MenuProvider() {
    //loadData();
  }

  Future<List<dynamic>> loadData() async {
    final resp = await rootBundle.loadString('data/menu_opts.json');
    Map dataMap = json.decode(resp);
    option = dataMap['routes'];

    return option;
  }
}

final menuProvider = new _MenuProvider();
