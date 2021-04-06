import 'package:flutter/material.dart';
import 'package:movil/src/blocs/provider.dart';
import 'package:movil/src/pages/sing_up_page.dart';
import 'package:movil/src/pages/verifynumber.dart';
import 'package:movil/src/providers/user_provider.dart';
import 'package:movil/src/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                //Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text(
                  'Inicio de Sesión',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 120.0),
            _filedUser(bloc),
            SizedBox(height: 12.0),
            _filedPassword(bloc),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                    Navigator.pop(context);
                  },
                ),
                _buttonLogin(bloc),
              ],
            ),
            FlatButton(
              child: Text(
                "Olvidaste la contraseña?",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifyScreeen(),
                  ),
                );
              },
            ),
            /* Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "No tienes una cuenta?  ",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Registrate",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 17),
                  ),
                ),
              ],
            ), */
          ],
        ),
      ),
    );
  }

  Widget _buttonLogin(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
              child: Text('Ingresar'),
              onPressed: snapshot.hasData ? () => _login(context, bloc) : null);
        });
  }

  Widget _filedUser(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.userStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: TextField(
              // controller: _usernameController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
                prefixIcon: Icon(Icons.account_circle),
                labelText: 'Usuario',
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeUser,
            ),
          );
        });
  }

  Widget _filedPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: TextField(
              // controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Contraseña',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              obscureText: true,
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  _login(BuildContext context, LoginBloc bloc) async {
    Map info = await userProvider.singIn(bloc.user, bloc.password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'MenuPage');
    } else {
      showAlert(context, info['error'], 'Usuario o Contraseña Invalidos');
    }
  }
}
