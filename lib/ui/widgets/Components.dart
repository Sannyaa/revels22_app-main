import 'package:flutter/material.dart';

Widget homePageButton(String name, Function()? onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
    child: ElevatedButton(onPressed: onPressed, child: Text(name)),
  );
}
