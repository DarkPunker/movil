import 'package:flutter/material.dart';
import 'package:movil/src/models/branch_model.dart';
import 'package:movil/src/models/inventory_model.dart';
import 'package:movil/src/providers/company_provider.dart';
import 'package:movil/src/providers/products_provider.dart';
import 'package:movil/src/utils/utils.dart';
import 'package:movil/src/widget/drawer_menu.dart';
import 'package:movil/src/widget/mensageSnackbar.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final branchOffices = new CompanyProvider();
  final productInventory = new ProductsProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _stockController = TextEditingController();

  ScrollController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Inventario'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          _nomalPopMenu(context),
        ],
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: _expansionPanelList(),
      )),
    );
  }

  Widget _nomalPopMenuBranch(BuildContext context) {
    return new PopupMenuButton<int>(
        itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
              new PopupMenuItem<int>(
                  value: 1, child: new Text('Agregar a Inventario')),
              new PopupMenuItem<int>(
                  value: 2, child: new Text('Habilitar Inventario')),
            ],
        onSelected: (int value) {
          switch (value) {
            case 1:
              print(value);
              break;
            case 2:
              print(value);
              break;
          }
        });
  }

  Widget _nomalPopMenuInventory(
      BuildContext context, InventoryModel inventory, BranchModel branch) {
    return new PopupMenuButton<int>(
        itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
              new PopupMenuItem<int>(value: 1, child: new Text('Editar')),
              new PopupMenuItem<int>(value: 2, child: new Text('Deshabilitar')),
              new PopupMenuItem<int>(
                  value: 3, child: new Text('Aumentar Stock')),
              new PopupMenuItem<int>(
                  value: 4, child: new Text('Disminuir Stock')),
            ],
        onSelected: (int value) {
          if (value != 1) {
            _showAlert(context, inventory, branch, value);
          } else {
            inventory.branch = branch;
            Navigator.pushNamed(context, 'EditInvetory', arguments: inventory);
          }
        });
  }

  Widget _nomalPopMenu(BuildContext context) {
    return new PopupMenuButton<int>(
        itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
              new PopupMenuItem<int>(
                  value: 1, child: new Text('Inventario Completo')),
            ],
        onSelected: (int value) {
          switch (value) {
            case 1:
              print(value);
              break;
          }
        });
  }

  Widget _expansionPanelList() {
    return FutureBuilder(
        future: branchOffices.getBranchOffices(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {});
              },
              children: _expansionPanel(context, snapshot.data),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  List<ExpansionPanel> _expansionPanel(
      BuildContext context, List<dynamic> data) {
    List<ExpansionPanel> items = [];
    data.forEach((element) {
      final widgetTemp = ExpansionPanel(
        headerBuilder: (context, bool isExpanded) {
          return ListTile(
            trailing: _nomalPopMenuBranch(context),
            title: Text('${element.branchName}'),
          );
        },
        body: SingleChildScrollView(child: _listProductsInventory(element)),
        isExpanded: true,
      );
      items.add(widgetTemp);
    });
    return items;
  }

  Widget _listProductsInventory(BranchModel branch) {
    return FutureBuilder<List<dynamic>>(
        future: productInventory.getProductsAvaliables(branch),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                controller: _controller,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _itemProductInventory(
                      context, snapshot.data[index], branch);
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _itemProductInventory(
      BuildContext context, InventoryModel inventory, BranchModel branch) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            trailing: _nomalPopMenuInventory(context, inventory, branch),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://image.freepik.com/vector-gratis/panda-bear-silhouette-plantilla-diseno-logotipo-icono-concepto-logotipo-animal-perezoso-divertido_126523-622.jpg'),
            ),
            title: Text('${inventory.product.code} ${inventory.product.name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Descripcion: ${inventory.product.description}'),
                Text('Stock: ${inventory.stock}'),
                Text(
                    'Precio de venta: ${String.fromCharCodes(new Runes('\u0024'))}${inventory.salePrice}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mensageAlert(BuildContext context, InventoryModel inventory,
      BranchModel branch, int option) {
    if (option == 2) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Desea deshabilitar el producto ${inventory.product.name}'),
          // FlutterLogo(size: 100.0)
        ],
      );
    } else {
      if (option == 3 || option == 4) {
        String title;
        switch (option) {
          case 3:
            title = 'aumentar';
            break;
          case 4:
            title = 'disminuir';
            break;
          default:
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Stock actual ${inventory.stock}'),
            Text(
                'Desea $title el Stock del porducto ${inventory.product.name}'),
            TextField(
              controller: _stockController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
                labelText: 'Cantidad',
              ),
            ),
          ],
        );
      }
    }
    return Text('Opcion fuera de rango');
  }

  Widget titleAlert(int option) {
    switch (option) {
      case 2:
        return Text('Cambiar Estado');
        break;
      case 3:
        return Text('Aumentar Stock');
        break;
      case 4:
        return Text('Disminuir Stock');
        break;
      default:
        return Text('Opcion fuera de rango');
    }
  }

  void _showAlert(BuildContext context, InventoryModel inventory,
      BranchModel branch, int option) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: titleAlert(option),
            content: mensageAlert(context, inventory, branch, option),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  if (option == 2) {
                    inventory.isActive = false;
                    productInventory.changeStatusInventories(inventory, branch);
                    mensageSnackbar('Producto del inventario deshabilitado',
                        1500, scaffoldKey);
                  } else {
                    if (isNumeric(_stockController.text)) {
                      inventory.stock = int.parse(_stockController.text);
                      switch (option) {
                        case 3:
                          productInventory.increaseInventory(inventory, branch);
                          mensageSnackbar(
                              'Inventario Incrementado', 1500, scaffoldKey);
                          break;
                        case 4:
                          productInventory.decreaseInventory(inventory, branch);
                          mensageSnackbar(
                              'Inventario Decrementado', 1500, scaffoldKey);
                          break;
                        default:
                      }
                    } else {
                      mensageSnackbar(
                          'Error revisar que son valores numéricos sin espacios ni caracteres',
                          3000,
                          scaffoldKey);
                    }
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }
}
