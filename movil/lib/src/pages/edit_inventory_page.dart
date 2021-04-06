import 'package:flutter/material.dart';
import 'package:movil/src/models/inventory_model.dart';
import 'package:movil/src/providers/products_provider.dart';
import 'package:movil/src/utils/utils.dart';
import 'package:movil/src/widget/mensageSnackbar.dart';

class EditInvetory extends StatefulWidget {
  @override
  _EditInvetoryState createState() => _EditInvetoryState();
}

class _EditInvetoryState extends State<EditInvetory> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  InventoryModel inventory = new InventoryModel();
  final productInventory = new ProductsProvider();
  @override
  Widget build(BuildContext context) {
    final InventoryModel inventoryData =
        ModalRoute.of(context).settings.arguments;
    inventory = inventoryData;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Editar Inventario'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                      '${inventoryData.product.code} ${inventoryData.product.name}'),
                ),
                _invetoryStock(),
                SizedBox(height: 12.0),
                _invetorySalePrice(),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    _buttonSave(),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget _invetoryStock() {
    return TextFormField(
      initialValue: inventory.stock.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Stock',
      ),
      onSaved: (value) => inventory.stock = int.parse(value),
      validator: (value) {
        if (isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _invetorySalePrice() {
    return TextFormField(
      initialValue: inventory.salePrice.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Precio de Inventario',
      ),
      onSaved: (value) => inventory.salePrice = int.parse(value),
      validator: (value) {
        if (isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _buttonSave() {
    return RaisedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      onPressed: _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    productInventory.editInventory(inventory);
    mensageSnackbar('Inventario Modificado', 1500, scaffoldKey);
  }
}
