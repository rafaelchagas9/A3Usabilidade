import 'package:flutter/material.dart';

const kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kTextBtnStyle = ButtonStyle(
  foregroundColor:
      MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
    if (states.contains(MaterialState.focused)) return Colors.red;
    if (states.contains(MaterialState.hovered)) {
      return Colors.amberAccent;
    }
    if (states.contains(MaterialState.pressed)) return Colors.blue;
    return Colors.white;
  }),
);

final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
