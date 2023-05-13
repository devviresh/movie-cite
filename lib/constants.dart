import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var kInputStyle = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    labelText: 'Enter');

const kBoxShadow =
    BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(4, 4));

const kAlertStyle = AlertStyle(
  titleStyle: TextStyle(color: Colors.white),
  descStyle: TextStyle(
      color: Colors.white70, fontWeight: FontWeight.normal, fontSize: 16.0),
  backgroundColor: Color(0xff303030),
  alertBorder: InputBorder.none,
);

var kCarouselOptions = CarouselOptions(
    autoPlay: true,
    enlargeCenterPage: true,
    autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(seconds: 2),
    height: 230,
    aspectRatio: 9 / 9,
    enlargeFactor: 0.2);
