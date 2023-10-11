import 'package:flutter/material.dart';
import 'package:fluttersimplon/styles.dart';

AppBar getAppBar() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Image.asset("assets/logo.png"),
        ),
        const Text(
          "Messagerie Simplon",
          style: appBarTitle,
        ),
      ],
    ),
  );
}
