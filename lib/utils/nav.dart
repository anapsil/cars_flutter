import 'package:flutter/material.dart';

Future push(BuildContext context, Widget screen, {bool replace = false}) {
  if (replace) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
  }

  return Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
