import 'package:flutter/material.dart';
import 'package:movil/src/blocs/scans_bloc.dart';
import 'package:movil/src/models/scan_model.dart';
import 'package:movil/src/utils/utils.dart';


class InvoiceList extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          scansBloc.getScans();
          return Center(
            child: Text('No hay facturas escaneadas'),
          );
        }
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text('No hay facturas escaneadas'),
          );
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) => scansBloc.deleteScans(scans[i].id),
            child: ListTile(
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              title: Text(scans[i].numFac),
              leading: Icon(
                Icons.cloud_queue,
                color: Theme.of(context).primaryColor,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Fecha: ${scans[i].fecFac}"),
                  Text("Nit: ${scans[i].nitFac}"),
                  Text("Total: ${scans[i].valTolFac}"),
                ],
              ),
              onTap: () {
                _showAlert(context, scans[i]);
              },
            ),
          ),
        );
      },
    );
  }

  void _showAlert(BuildContext context, ScanModel scan) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(scan.numFac),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Fecha: ${scan.fecFac}"),
                  Text('Hora: ${scan.horFac}'),
                  Text("Nit: ${scan.nitFac}"),
                  Text("DocAdq: ${scan.docAdq}"),
                  Text("Valor: ${scan.valFac}"),
                  Text("Iva: ${scan.valIva}"),
                  Text("Otro impuesto: ${scan.valOtroIm}"),
                  Text("Total: ${scan.valTolFac}"),
                  Text("CUFE: ${scan.cufe}"),
                  Text("URL: ${scan.qrcufe}"),
                ]),
            actions: <Widget>[
              FlatButton(
                child: Text('Ver'),
                onPressed: () {
                  loadURL(context, scan);
                },
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
