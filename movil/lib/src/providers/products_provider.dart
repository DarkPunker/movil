import 'package:http/http.dart' as http;
import 'package:movil/src/models/branch_model.dart';
import 'package:movil/src/models/inventory_model.dart';
import 'dart:convert';
import 'package:movil/src/models/product_,model.dart';
import 'package:movil/src/providers/http_complements.dart';

class ProductsProvider {
  Future<List<Product>> getProducts() async {
    final resp = await http.get(uriGetProducts());
    final decodedData = json.decode(resp.body);
    if (decodedData == null) return [];
    final products = new Products.fromJsonList(decodedData);
    return products.items;
  }

  Future<bool> createProducts(Product product) async {
    final resp = await http.post(uriCreateProducts(),
        headers: headerContent(), body: jsonEncode(product.toJson()));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> editProducts(Product product) async {
    final resp = await http.put(uriEditProducts(),
        headers: headerContent(), body: jsonEncode(product.toJson()));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<InventoryModel>> getProductsAvaliables(BranchModel branch) async {
    print(branch.idBranch);
    final resp = await http.get(uriGetProductsAvaliables(branch.idBranch),
        headers: headerContentAuth());
    final decodedData = json.decode(resp.body);
    if (decodedData == null) return [];
    print(decodedData);
    final inventory = new InventaryProducts.fromJsonList(decodedData);
    return inventory.items;
  }

  Future<bool> changeStatusInventories(
      InventoryModel inventory, BranchModel branch) async {
    final resp = await http.put(uriChangeStatusInventories(),
        headers: headerContent(),
        body: jsonEncode(inventory.toJsonidBranch(branch)));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> decreaseInventory(
      InventoryModel inventory, BranchModel branch) async {
    final resp = await http.patch(uriDecreaseInventory(),
        headers: headerContent(),
        body: jsonEncode(inventory.toJsonStock(branch)));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> increaseInventory(
      InventoryModel inventory, BranchModel branch) async {
    final resp = await http.patch(uriIncreaseInventory(),
        headers: headerContent(),
        body: jsonEncode(inventory.toJsonStock(branch)));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> editInventory(InventoryModel inventory) async {
    final resp = await http.put(uriEditInventory(),
        headers: headerContent(), body: jsonEncode(inventory.toJsonEdit()));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }
}
