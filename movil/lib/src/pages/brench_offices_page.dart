import 'package:flutter/material.dart';
import 'package:movil/src/models/branch_model.dart';
import 'package:movil/src/providers/company_provider.dart';

class BranchOfficesPage extends StatefulWidget {
  @override
  _BranchOfficesState createState() => _BranchOfficesState();
}

class _BranchOfficesState extends State<BranchOfficesPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final branchProvider = new CompanyProvider();
  BranchModel branch = new BranchModel();
  @override
  Widget build(BuildContext context) {
    final BranchModel branchData = ModalRoute.of(context).settings.arguments;
    if (branchData != null) {
      branch = branchData;
    }
    branch.idMunicipality = 352;
    branch.idCompany = 1;
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Sucursal'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _branchName(),
                    SizedBox(height: 12.0),
                    _branchAddress(),
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
        ));
  }

  Widget _branchName() {
    return TextFormField(
      initialValue: branch.branchName,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Nombre Sucursal',
      ),
      onSaved: (value) => branch.branchName = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese Nombre Sucursal';
        } else {
          return null;
        }
      },
    );
  }

  Widget _branchAddress() {
    return TextFormField(
      initialValue: branch.address,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Dirección',
      ),
      onSaved: (value) => branch.address = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese Dirección';
        } else {
          return null;
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

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    if (branch.idBranch == null) {
      int id = await branchProvider.createBranch(branch);
      BranchModel branchaux = new BranchModel();
      branchaux.idBranch = id;
      _showAlert(context, branchaux);
      mensageSnackbar('Sucursal Guardada');
    } else {
      branchProvider.editBranch(branch);
      mensageSnackbar('Sucursal Modificada');
    }
  }

  void mensageSnackbar(String mensage) {
    final snackbar = SnackBar(
      content: Text(mensage),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _showAlert(BuildContext context, BranchModel branch) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Generar Inventario'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Desea generar automáticamente el inventario con los productos existentes?'),
                // FlutterLogo(size: 100.0)
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  branchProvider.generateAutomaticInventory(branch);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
