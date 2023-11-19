import 'package:flutter/material.dart';

Widget loading(BuildContext context) {
  return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Image.asset(
        "assets/loading.gif",
        fit: BoxFit.fitWidth,
      ));
}
