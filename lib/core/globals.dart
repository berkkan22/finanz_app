import 'package:finanz_app/models/konten.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger();

const String hiveKontenBox = 'konten';
const String hiveTransaktionBox = 'transaktions';
const String hiveKategorieBox = 'kategorie';

final DateFormat formatter = DateFormat('dd.MM.yyyy');

const dayInMicroSeconds = 86400000000;

// Colors
const primary = Color(0xFF4B4B4B);
const primary2 = Color(0xFF6E6E6E);
const grey = Color(0xFF2D2D2D);
const second = Color(0xFFC876FF);
const white = Color(0xFFFFFFFF);

const List<Color> colors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

List<Kategorie> listOfKategories = [
  Kategorie(name: 'Essen', color: 0xFFE57373, iconName: 'fastfood'),
  Kategorie(name: 'Shopping', color: 0xFFBA68C8, iconName: 'shopping_bag'),
  Kategorie(name: 'Reisen', color: 0xFF64B5F6, iconName: 'car_crash'),
  Kategorie(name: 'Geschenke', color: 0xFF81C784, iconName: 'wallet_giftcard'),
  Kategorie(name: 'Gehalt', color: 0xFFFFB74D, iconName: 'work'),
  Kategorie(
      name: 'Sonstiges', color: 0xFFAED581, iconName: 'onetwothree_sharp'),
  Kategorie(name: 'Hinzufügen', color: 0xFFAED581, iconName: 'add'),
];
