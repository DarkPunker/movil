import 'package:flutter/material.dart';
import 'package:movil/src/models/branch_model.dart';
import 'package:movil/src/providers/company_provider.dart';
import 'package:movil/src/widget/drawer_menu.dart';

class BranchPage extends StatelessWidget {
  final branchOffices = new CompanyProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sucursal'),
      ),
      drawer: MenuDrawer(),
      body: _listBranchOffices(),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'NewBranch'),
      ),
    );
  }

  Widget _listBranchOffices() {
    return FutureBuilder<List<BranchModel>>(
      future: branchOffices.getBranchOffices(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return _itemBranch(context, snapshot.data[index]);
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _itemBranch(BuildContext context, BranchModel branch) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            trailing: _nomalPopMenu(context, branch),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://image.freepik.com/vector-gratis/panda-bear-silhouette-plantilla-diseno-logotipo-icono-concepto-logotipo-animal-perezoso-divertido_126523-622.jpg'),
            ),
            title: Text('${branch.branchName}'),
            subtitle:
                Text('Direccion: ${branch.address} ${branch.idMunicipality}'),
          ),
        ],
      ),
    );
  }

  Widget _nomalPopMenu(BuildContext context, BranchModel branch) {
    String state = 'Habilitar';
    if (branch.isActive) state = 'Deshabilitar';
    return new PopupMenuButton<int>(
        itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
              new PopupMenuItem<int>(value: 1, child: new Text('Numeración')),
              new PopupMenuItem<int>(value: 2, child: new Text('Editar')),
              new PopupMenuItem<int>(value: 3, child: new Text(state)),
            ],
        onSelected: (int value) {
          switch (value) {
            case 1:
              print(value);
              break;
            case 2:
              Navigator.pushNamed(context, 'NewBranch', arguments: branch);
              break;
            case 3:
              _showAlert(context, state, branch);
              break;
          }
        });
  }

  void _showAlert(BuildContext context, String state, BranchModel branch) {
    final branchProvider = new CompanyProvider();
    if (branch.isActive) {
      branch.isActive = false;
    } else {
      branch.isActive = true;
    }
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Cambiar Estado'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Desea $state la sucursal'),
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
                  branchProvider.changeStatusBranch(branch);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
