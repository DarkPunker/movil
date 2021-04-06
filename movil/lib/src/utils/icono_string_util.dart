import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _icon = <String, IconData>{
  "add_alert": Icons.add_alert,
  "accessibility": Icons.accessibility,
  "folder_open": Icons.folder_open,
  "cog": FontAwesomeIcons.cog,
  "boxOpen": FontAwesomeIcons.boxOpen,
  "home": FontAwesomeIcons.home,
  "pallet":FontAwesomeIcons.pallet,
  "fileInvoice":FontAwesomeIcons.fileInvoice,
};

Icon getIcon(String iconName) {
  return Icon(_icon[iconName]);
}
