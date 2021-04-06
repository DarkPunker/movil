import 'dart:io';

import 'package:movil/src/Userpreferences/user_preferences.dart';

final _prefs = new UserPreferences();

String _uri = '10.0.2.2:5000';

String _version = 'v1';

Map<String, String> headerContent() {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}

Map<String, String> headerContentAuth() {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: "Bearer ${_prefs.accessToken}",
  };
}

String getProductsUrl(int id) {
  return '/$_version/products/company/$id';
}

String _createProductsUrl = '/$_version/products';

String _editProductsUrl = '/$_version/products';

String _changeStatusInventoriesUrl = '/$_version/inventories/changeStatus';

String _decreaseInventorysUrl = '/$_version/inventories/decrement';

String _increaseInventoryUrl = '/$_version/inventories/increment';

String _editInventoryUrl = '/$_version/inventories';

String generateAutomaticInventoryUrl(int id) {
  return '/$_version/inventories/generate-inventory/branch/$id';
}

String getProductsAvaliablesUrl(int id) {
  return '/$_version/inventories/products-avaliables/$id';
}

String getBranchOfficesUrl(int id) {
  return '/$_version/companies/$id/branch-offices/';
}

String _createBranchUrl = '/$_version/branch-offices';

String _editBranchUrl = '/$_version/branch-offices';

String changeStatusBranchUrl(int id) {
  return '/$_version/branch-offices/change-state/$id';
}

String _getTaxesUrl = '/$_version/tax';

String _getUnitMeasurementUrl = '/$_version/unit-measurement';

String _singInUrl = '/$_version/auth/signin';

Uri uriGetTaxes() {
  return Uri.http(_uri, _getTaxesUrl);
}

Uri uriGetUnitMeasurement() {
  return Uri.http(_uri, _getUnitMeasurementUrl);
}

Uri uriGetProducts() {
  return Uri.http(_uri, getProductsUrl(1));
}

Uri uriCreateProducts() {
  return Uri.http(_uri, _createProductsUrl);
}

Uri uriEditProducts() {
  return Uri.http(_uri, _editProductsUrl);
}

Uri uriGetProductsAvaliables(int id) {
  return Uri.http(_uri, getProductsAvaliablesUrl(id));
}

Uri uriChangeStatusInventories() {
  return Uri.http(_uri, _changeStatusInventoriesUrl);
}

Uri uriDecreaseInventory() {
  return Uri.http(_uri, _decreaseInventorysUrl);
}

Uri uriIncreaseInventory() {
  return Uri.http(_uri, _increaseInventoryUrl);
}

Uri uriEditInventory() {
  return Uri.http(_uri, _editInventoryUrl);
}

Uri uriGenerateAutomaticInventory(int id) {
  return Uri.http(_uri, generateAutomaticInventoryUrl(id));
}

Uri uriSingIn() {
  return Uri.http(_uri, _singInUrl);
}

Uri uriGetBranchOffices(int id) {
  return Uri.http(_uri, getBranchOfficesUrl(id));
}

Uri uriCreateBranch() {
  return Uri.http(_uri, _createBranchUrl);
}

Uri uriEditBranch() {
  return Uri.http(_uri, _editBranchUrl);
}

Uri uriChangeStatusBranch(int id) {
  return Uri.http(_uri, changeStatusBranchUrl(id));
}
