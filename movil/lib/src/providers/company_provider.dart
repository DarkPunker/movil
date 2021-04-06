import 'package:movil/src/models/branch_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movil/src/providers/http_complements.dart';

class CompanyProvider {
  Future<List<BranchModel>> getBranchOffices() async {
    final resp = await http.get(uriGetBranchOffices(1), headers: headerContentAuth());
    print(resp.body);
    final decodedData = json.decode(resp.body);
    if (decodedData == null) return [];
    final data = decodedData['branchs'];
    if (data == null) return [];
    final branchOffices = new BranchOffices.fromJsonList(data);
    return branchOffices.items;
  }

  Future<int> createBranch(BranchModel branch) async {
    final resp = await http.post(uriCreateBranch(),
        headers: headerContent(), body: jsonEncode(branch.toJson()));
    final decodedData = json.decode(resp.body);
    return decodedData['idBranch'];
  }

  Future<bool> editBranch(BranchModel branch) async {
    final resp = await http.put(uriEditBranch(),
        headers: headerContent(), body: jsonEncode(branch.toJson()));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> changeStatusBranch(BranchModel branch) async {
    final resp = await http.patch(
      uriChangeStatusBranch(branch.idBranch),
      headers: headerContent(),
      body: jsonEncode(branch.toJsonState()),
    );
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> generateAutomaticInventory(BranchModel branch) async {
    final resp = await http.post(
      uriGenerateAutomaticInventory(branch.idBranch),
      headers: headerContent(),
    );
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }
}
