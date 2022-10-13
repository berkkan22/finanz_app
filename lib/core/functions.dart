import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

String getKontoNameFromId(int id) {
  var box = Hive.box(hiveKontenBox);

  for (int ids in box.keys) {
    if (ids == id) {
      Konten konto = box.getAt(id);
      return konto.name;
    }
  }
  return "Konto nicht gefunden";
}

toastMsg(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
  );
}
