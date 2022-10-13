import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TransaktionState {
  const TransaktionState();
}

class TransaktionInitialState extends TransaktionState {
  const TransaktionInitialState();
}

class TransaktionLoadingState extends TransaktionState {
  const TransaktionLoadingState();
}

class TransaktionLoadedState extends TransaktionState {
  final List<Transaktion> transaktionList;
  TransaktionLoadedState(this.transaktionList);
}

class TransaktionErrorState extends TransaktionState {
  String errorMessage;
  TransaktionErrorState(this.errorMessage);
}

final transaktionNotifierProvider = StateNotifierProvider((ref) {
  return TransaktionStateNotifier();
});

class TransaktionStateNotifier extends StateNotifier<TransaktionState> {
  TransaktionStateNotifier() : super(const TransaktionInitialState());

  Future<void> getFromDB() async {
    state = const TransaktionLoadingState();

    final box = Hive.box(hiveTransaktionBox);

    final List<Transaktion> transaktionData = box.keys.map((key) {
      final Transaktion value = box.get(key);
      return value;
    }).toList();

    if (transaktionData.isEmpty) {
      state = const TransaktionInitialState();
    } else {
      state = TransaktionLoadedState(transaktionData);
    }
  }

  Future<void> addTransaktion(Transaktion transaktion) async {
    state = const TransaktionLoadingState();

    final box = Hive.box("transaktions");

    box.add(transaktion);

    getFromDB();
  }

  Future<void> deletedAll() async {
    final box = Hive.box('transaktions');

    for (int key in box.keys) {
      box.delete(key);
    }

    getFromDB();
  }
}
