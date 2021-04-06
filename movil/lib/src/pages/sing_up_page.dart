import 'package:flutter/material.dart';
import 'package:movil/src/models/person_model.dart';
import 'package:movil/src/pages/menu_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  Person person = new Person();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            child: Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Column(
                    children: <Widget>[
                      //Image.asset('assets/diamond.png'),
                      SizedBox(height: 16.0),
                      Text(
                        'Registro',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  _identificationNumber(),
                  SizedBox(height: 10.0),
                  _firstName(),
                  SizedBox(height: 10.0),
                  _lastName(),
                  SizedBox(height: 10.0),
                  _email(),
                  // TextField(
                  //   controller: _passwordController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //     filled: true,
                  //     labelText: 'Contraseña',
                  //   ),
                  //   obscureText: true,
                  // ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      RaisedButton(
                        child: Text('Guardar'),
                        onPressed: () {
                          final route = MaterialPageRoute(
                            builder: (context) => MenuPage(),
                          );
                          Navigator.push(context, route);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _identificationNumber() {
    return TextFormField(
      initialValue: null,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Numero de Identificacion',
        //icon: Icon(Icons.account_circle),
      ),
      onSaved: (value) => person.cc = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese identificacion';
        } else {
          return null;
        }
      },
    );
  }

  Widget _firstName() {
    return TextFormField(
      initialValue: null,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Nombre',
        // icon: Icon(Icons.account_circle),
      ),
      onSaved: (value) => person.name = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _lastName() {
    return TextFormField(
      initialValue: null,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Apellido',
        // icon: Icon(Icons.account_circle),
      ),
      onSaved: (value) => person.lastname = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese Apellido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _email() {
    return TextFormField(
      initialValue: null,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        labelText: 'Email',
        // icon: Icon(Icons.account_circle),
      ),
      onSaved: (value) => person.email = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese Email';
        } else {
          return null;
        }
      },
    );
  }
}

