import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movil/src/models/product_,model.dart';
import 'package:movil/src/providers/UnitMeasurement_provider.dart';
import 'package:movil/src/providers/products_provider.dart';
import 'package:movil/src/providers/taxes_provider.dart';
import 'package:movil/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movil/src/widget/mensageSnackbar.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final taxes = new TaxesProvider();
  final unit = new UnitMeasurementProvider();
  final productProvider = new ProductsProvider();
  Product product = new Product();
  File photo;
  String dropdownValueTax;

  String dropdownValueUnit;

  @override
  Widget build(BuildContext context) {
    final Product prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      product = prodData;
    }
    product.idCompany = 1;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectPhoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takephoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _showPhoto(),
                  SizedBox(height: 12.0),
                  _productCode(),
                  SizedBox(height: 12.0),
                  _productName(),
                  SizedBox(height: 12.0),
                  _productDescription(),
                  SizedBox(height: 12.0),
                  _dropdownButtonUnit(context),
                  SizedBox(height: 12.0),
                  _productValue(),
                  SizedBox(height: 12.0),
                  _dropdownButtonTax(context),
                  SizedBox(height: 12.0),
                  _available(),
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
      ),
    );
  }

  Widget _productCode() {
    return TextFormField(
      initialValue: product.code,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Codigo',
      ),
      onSaved: (value) => product.code = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese Codigo';
        } else {
          return null;
        }
      },
    );
  }

  Widget _productName() {
    return TextFormField(
      initialValue: product.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Nombre',
      ),
      onSaved: (value) => product.name = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese Nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _productDescription() {
    return TextFormField(
        initialValue: product.description,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          filled: true,
          labelText: 'Descripcion',
        ),
        onSaved: (value) => product.description = value,
        validator: (value) {
          if (value.length < 1) {
            return 'Ingrese Descripcion';
          } else {
            return null;
          }
        });
  }

  Widget _productValue() {
    return TextFormField(
      initialValue: product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Precio de Inventario',
      ),
      onSaved: (value) => product.value = int.parse(value),
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

  Widget _dropdownButtonTax(BuildContext context) {
    List<int> arrayTaxid = [];
    return FutureBuilder(
      future: taxes.getTaxes(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField(
            hint: Text("Impuesto"),
            value: dropdownValueTax,
            isExpanded: true,
            //isDense: true,
            icon: Icon(Icons.arrow_downward),
            items: _taxDropdownMenuItem(snapshot.data),
            onSaved: (newValue) {
              arrayTaxid.add(newValue.id);
              return product.taxes = arrayTaxid;
            },
            onChanged: (newValue) {
              setState(() {
                dropdownValueTax = newValue;
              });
            },
            validator: (value) {
              if (value != null) {
                return null;
              } else {
                return 'Seleccione un impuesto';
              }
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _dropdownButtonUnit(BuildContext context) {
    return FutureBuilder(
      future: unit.getUnitMeasurement(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField(
            hint: Text("Unidad de Medida"),
            value: dropdownValueUnit,
            isExpanded: true,
            //isDense: true,
            icon: Icon(Icons.arrow_downward),
            items: _unitDropdownMenuItem(snapshot.data),
            onSaved: (newValue) => product.idUnitMeasurement = newValue.id,
            onChanged: (newValue) {
              setState(() {
                dropdownValueUnit = newValue;
              });
            },
            validator: (value) {
              if (value != null) {
                return null;
              } else {
                return 'Seleccione una unidad de medida';
              }
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<DropdownMenuItem<dynamic>> _taxDropdownMenuItem(List<dynamic> data) {
    final List<DropdownMenuItem<dynamic>> items = [];
    data.forEach((element) {
      final widgetTemp = DropdownMenuItem(
        child: Text(
            '${element.name} ${(element.percentage * 100).toStringAsFixed(1)}%'),
        value: element,
      );
      items.add(widgetTemp);
    });
    return items;
  }

  List<DropdownMenuItem<dynamic>> _unitDropdownMenuItem(List<dynamic> data) {
    final List<DropdownMenuItem<dynamic>> items = [];
    data.forEach((element) {
      final widgetTemp = DropdownMenuItem(
        child: Text('${element.name} (${element.symbol})'),
        value: element,
      );
      items.add(widgetTemp);
    });
    return items;
  }

  Widget _available() {
    return SwitchListTile(
      value: product.state,
      title: Text('Disponible'),
      onChanged: (value) => setState(() {
        product.state = value;
      }),
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    if (product.id == null) {
      productProvider.createProducts(product);
      mensageSnackbar('Producto Guardado',1500, scaffoldKey);
    } else {
      productProvider.editProducts(product);
      mensageSnackbar('Producto Modificado',1500, scaffoldKey);
    }
  }

  _showPhoto() {
    if (product.photoUrl != null) {
      return Container();
    } else {
      return Image(
        image: AssetImage(photo?.path ?? 'assets/images/no-image.png'),
        height: 300,
        fit: BoxFit.cover,
      );
    }
  }

  _processImage(ImageSource origin) async {
    photo = await ImagePicker.pickImage(source: origin);

    if (photo != null) {
      // product.photoUrl = null;
    }

    setState(() {
      print('tenemos foto');
    });
  }

  _selectPhoto() async {
    _processImage(ImageSource.gallery);
  }

  _takephoto() async {
    _processImage(ImageSource.camera);
  }
}
