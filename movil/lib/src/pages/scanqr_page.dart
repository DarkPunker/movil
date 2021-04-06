import 'package:flutter/material.dart';
import 'package:movil/src/blocs/scans_bloc.dart';
import 'package:movil/src/models/scan_model.dart';
import 'package:movil/src/pages/scan_qr_invoice.dart';
import 'package:movil/src/utils/utils.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class ScanQr extends StatefulWidget {
  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  int currentIndex = 0;

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('QR Scanner')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.deleteAllScans,
          )
        ],
      ),
      body: InvoiceList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () {
          _scanQr();
        },
      ),
    );
  }

  _scanQr() async {
    String futureString = '';
    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }
    print(futureString);
    if (futureString != null) {
      ScanModel scan = scanModelFromString(futureString.split("\n"));
      if (scan != null) {
        scansBloc.addScan(scan);
      } else {
        showAlert(context, "Codigo QR erroneo", "Alerta");
      }
    }
  }
}
