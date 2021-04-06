import 'dart:convert';

import 'package:movil/src/models/branch_model.dart';
import 'package:movil/src/models/product_,model.dart';

class InventaryProducts {
  List<InventoryModel> items = new List();

  InventaryProducts();

  InventaryProducts.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final branch = new InventoryModel.fromJson(item);
      items.add(branch);
    }
  }
}

InventoryModel InventoryModelFromJson(String str) =>
    InventoryModel.fromJson(json.decode(str));

String InventoryModelToJson(InventoryModel data) => json.encode(data.toJson());

class InventoryModel {
  InventoryModel({this.stock, this.salePrice, this.isActive, this.product, this.branch});

  int stock;
  int salePrice;
  bool isActive;
  Product product;
  BranchModel branch;

  factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
      stock: json["stock"],
      salePrice: json["salePrice"],
      isActive: json["isActive"],
      product: Product.fromJsonMap(json["product"]),
      //branch: BranchModel.fromJson(json["branch"])
      );

  Map<String, dynamic> toJson() => {
        "stock": stock,
        "salePrice": salePrice,
        "isActive": isActive,
        "idProduct": product.id,
      };

  Map<String, dynamic> toJsonidBranch(BranchModel branch) => {
        "isActive": isActive,
        "idBranch": branch.idBranch,
        "idProduct": product.id,
      };

  Map<String, dynamic> toJsonStock(BranchModel branch) => {
        "stock": stock,
        "idBranch": branch.idBranch,
        "idProduct": product.id,
      };
  
  Map<String, dynamic> toJsonEdit() => {
        "idBranch": branch.idBranch,
        "idProduct": product.id,
        "isActive": isActive,
        "stock": stock,
        "salePrice": salePrice,
      };

  void addProduct(Product product) {
    this.product = product;
  }
}
