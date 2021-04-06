import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movil/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void showAlert(BuildContext context, String message, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}

loadURL(BuildContext context, ScanModel scan) async {
  if (scan.qrcufe != "") {
    if (await canLaunch(scan.qrcufe)) {
      await launch(scan.qrcufe);
    } else {
      showAlert(context, "No se pudo abrir el url","Información");
    }
  } else {
    showAlert(context, "No existe enlace url", "Información");
  }
}
