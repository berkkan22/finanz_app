import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

String getKontoNameFromId(int id) {
  var box = Hive.box(hiveKontenBox);

  for (int ids in box.keys) {
    if (ids == id) {
      Konten konto = box.get(id);
      return konto.name;
    }
  }
  return "Konto nicht gefunden";
}

List<Kategorie> getAllKategorien() {
  var box = Hive.box(hiveKategorieBox);

  List<Kategorie> kategorien = box.keys.map((key) {
    Kategorie value = box.get(key);
    return value;
  }).toList();

  return kategorien.isNotEmpty ? kategorien : listOfKategories;
}

toastMsg(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
  );
}
