import 'dart:async';

import 'package:movil/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _userController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get userStream =>
      _userController.stream.transform(validateUser);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(userStream, passwordStream, (a, b) => true);

  // Insertar valores al Stream
  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get user => _userController.value;
  String get password => _passwordController.value;

  dispose() {
    _userController?.close();
    _passwordController?.close();
  }
}
