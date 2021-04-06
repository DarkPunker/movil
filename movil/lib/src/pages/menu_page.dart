import 'package:flutter/material.dart';
import 'package:movil/src/providers/menu_provider.dart';
import 'package:movil/src/utils/icono_string_util.dart';

class MenuPage extends StatelessWidget {
  static final String routName = 'MenuPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Menu')),
        ),
        body: _list());
  }

  Widget _list() {
    return FutureBuilder(
      future: menuProvider.loadData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _itemList(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _itemList(List<dynamic> data, BuildContext context) {
    final List<Widget> option = [];
    data.forEach((opt) {
      final widgetTemp = _cardMenu(context, opt);
      option.add(widgetTemp);
    });
    return option;
  }

  Widget _cardMenu(BuildContext context, dynamic opt) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(opt['text']),
            leading: getIcon(opt['icon']),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, opt['route']);
            },
          )
        ],
      ),
    );
  }
}
