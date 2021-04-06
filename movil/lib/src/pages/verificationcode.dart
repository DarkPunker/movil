import 'package:flutter/material.dart';
import 'package:movil/src/pages/home_page.dart';
import 'package:movil/src/utils/codeinput.dart';

import 'package:movil/src/utils/progressdialog.dart';


class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Verifying account...');
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 96.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text("Verificación del teléfono",
                      style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 48.0),
                  child: Text(
                    "Ingrese su código aquí",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 64.0),
                  child: CodeInput(
                    length: 4,
                    keyboardType: TextInputType.number,
                    builder: CodeInputBuilders.darkCircle(),
                    onFilled: (value) async {
                      print('Su entrada es $value.');
                      pr.show();
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          pr.hide();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        });
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "No recibiste ningún código?",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    ),
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Reenviar nuevo código",
                      style: TextStyle(
                        fontSize: 19,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
