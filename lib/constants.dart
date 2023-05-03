import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var kInputStyle = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0)
    ),
    labelText: 'Enter'
);

const kBoxShadow = BoxShadow(
    color: Colors.black26,
    blurRadius: 4,
    offset: Offset(4, 4));

const kAlertStyle = AlertStyle(
    titleStyle: TextStyle(
        color: Colors.white
    ),
    descStyle: TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.normal,
        fontSize: 16.0
    ),
    backgroundColor: Color(0xff303030),
    alertBorder: InputBorder.none,
);