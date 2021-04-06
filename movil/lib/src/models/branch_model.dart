import 'dart:convert';

class BranchOffices {
  List<BranchModel> items = new List();

  BranchOffices();

  BranchOffices.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final branch = new BranchModel.fromJson(item);
      items.add(branch);
    }
  }
}

BranchModel branchModelFromJson(String str) =>
    BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  BranchModel({
    this.idBranch,
    this.branchName,
    this.address,
    this.isActive,
    this.idCompany,
    this.idMunicipality,
  });

  int idBranch;
  String branchName;
  String address;
  bool isActive;
  int idCompany;
  int idMunicipality;
  
factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        idBranch: json["idBranch"],
        branchName: json["branchName"],
        address: json["address"],
        isActive: json["isActive"],
        idCompany: json["idCompany"],
        idMunicipality: json["idMunicipality"],
      );

  Map<String, dynamic> toJson() => {
        "idBranch": idBranch,
        "branchName": branchName,
        "address": address,
        "isActive": isActive,
        "idCompany": idCompany,
        "idMunicipality": idMunicipality,
      };

  Map<String, dynamic> toJsonState() => {
        "state": isActive,
      };
}
