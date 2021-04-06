import 'package:flutter/material.dart';
import 'package:movil/src/pages/branch.dart';
import 'package:movil/src/pages/brench_offices_page.dart';
import 'package:movil/src/pages/edit_inventory_page.dart';
import 'package:movil/src/pages/home_page.dart';
import 'package:movil/src/pages/inventory_page.dart';
import 'package:movil/src/pages/invoice_page.dart';
import 'package:movil/src/pages/menu_page.dart';
import 'package:movil/src/pages/new_product.dart';
import 'package:movil/src/pages/products.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/' : (BuildContext context) => HomePage(),
    'MenuPage' : (BuildContext context) => MenuPage(),
    'Product' : (BuildContext context) => ProductsPage(),
    'NewProduct' : (BuildContext context) => NewProduct(),
    'NewBranch' : (BuildContext context) => BranchOfficesPage(),

    'Inventory' : (BuildContext context) => InventoryPage(),
    'Invoice' : (BuildContext context) => InvoicePage(), 
    'Branch' : (BuildContext context) => BranchPage(),
    'EditInvetory': (BuildContext context) => EditInvetory(),
  };
}
