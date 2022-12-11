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

    for (int key in box.keys) {
      box.delete(key);
    }

    getFromDB();
  }

  List<Konten> getKonten() {
    final box = Hive.box('konten');

    final List<Konten> kontenData = box.keys.map((key) {
      final Konten value = box.get(key);
      return value;
    }).toList();

    return kontenData;
  }

  int getKontenLength() {
    final box = Hive.box('konten');

    return box.length;
  }
}


// @freezed
// class ListState with _$ListState {
//   const factory ListState.init() = Init;
//   const factory ListState.loading() = Loading;
//   const factory ListState.loaded(List<Konten> konten) = Loaded;
//   const factory ListState.error(String? errorMessage) = Error;
// }
