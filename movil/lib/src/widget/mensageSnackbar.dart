import 'package:flutter/material.dart';

void mensageSnackbar(String mensage, int time, GlobalKey<ScaffoldState> key) {
    final snackbar = SnackBar(
      content: Text(mensage),
      duration: Duration(milliseconds: time),
    );
    key.currentState.showSnackBar(snackbar);
  }