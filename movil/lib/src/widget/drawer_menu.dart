import 'package:flutter/material.dart';
import 'package:movil/src/providers/menu_provider.dart';
import 'package:movil/src/utils/icono_string_util.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              height: 150,
              child: DrawerHeader(
                child: ListTile(
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 30,
                  ),
                  subtitle: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.fade,
                      //     child: UserSettings(),
                      //   ),
                      // );
                    },
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        /* color: blackColor */
                      ),
                    ),
                  ),
                  title: Text(
                    "NameCompani",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      /* color: blackColor */
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF8FAFB),
                ),
              ),
            ),
            _list(),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return FutureBuilder(
      future: menuProvider.loadData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return Column(
          children: _itemList(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _itemList(List<dynamic> data, BuildContext context) {
    final List<Widget> option = [];
    data.forEach((opt) {
      final widgetTemp = _listTitleMenu(context, opt);
      option.add(widgetTemp);
    });
    return option;
  }

  Widget _listTitleMenu(BuildContext context, dynamic opt) {
    return ListTile(
      title: Text(opt['text']),
      leading: getIcon(opt['icon']),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, opt['route']);
      },
    );
  }
}
