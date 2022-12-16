import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class KontenState {
  const KontenState();
}

class KontenInit extends KontenState {
  const KontenInit();
}

class KontenLoading extends KontenState {
  const KontenLoading();
}

class KontenLoaded extends KontenState {
  final List<Konten> konten;
  const KontenLoaded(this.konten);
}

class KontenError extends KontenState {
  final String errorMessage;
  const KontenError(this.errorMessage);
}

final kontenNotifierProvider = StateNotifierProvider((ref) {
  return KontenStateNotifier();
});

class KontenStateNotifier extends StateNotifier<KontenState> {
  KontenStateNotifier() : super(const KontenInit());

  Future<void> getFromDB() async {
    state = const KontenLoading();

    final box = Hive.box('konten');

    final List<Konten> kontenData = box.keys.map((key) {
      final Konten value = box.get(key);
      logger.d(key);
      return value;
    }).toList();

    // print(kontenData[0].name);
    print(kontenData.length);

    state = KontenLoaded(kontenData);

    print(state.runtimeType);
  }

  Future<void> add(Konten konto) async {
    final box = Hive.box('konten');

    box.add(konto);

    getFromDB();
  }

  Future<void> deletedAll() async {
    final box = Hive.box('konten');
    final boxTrans = Hive.box('transaktions');

    for (int keyKonto in box.keys) {
      for (int keyTrans in boxTrans.keys) {
        int transKontoId = boxTrans.get(keyTrans).vonKontoId;
        if (boxTrans.get(keyTrans).vonKontoId == keyKonto) {
          boxTrans.delete(keyTrans);
        }
      }

      box.delete(keyKonto);
    }

    getFromDB();
  }

  Future<void> delete(int id) async {
    final box = Hive.box('konten');

    box.delete(id);

    // delete all transactions from this konto
    final boxTrans = Hive.box('transaktionen');
    for (int key in boxTrans.keys) {
      if (boxTrans.get(key).kontoId == id) {
        boxTrans.delete(key);
      }
    }

    getFromDB();
  }

  List<Konten> getKonten() {
    final box = Hive.box('konten');

    final List<Konten> kontenData = box.keys.map((key) {
      Konten value = box.get(key);
      value.id ??= key;

      return value;
    }).toList();

    return kontenData;
  }

  int getKontenLength() {
    final box = Hive.box('konten');

    return box.length;
  }
}
