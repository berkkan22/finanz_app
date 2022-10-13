import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

abstract class ChartState {
  const ChartState();
}

class ChartInitialState extends ChartState {
  const ChartInitialState();
}

class ChartLoadingState extends ChartState {
  const ChartLoadingState();
}

class ChartLoadedState extends ChartState {
  final List total;
  ChartLoadedState(this.total);
}

class ChartErrorState extends ChartState {
  String error;
  ChartErrorState(this.error);
}

final chartProviderNotifier = StateNotifierProvider((ref) {
  return ChartStateNotifier();
});

class ChartStateNotifier extends StateNotifier<ChartState> {
  ChartStateNotifier() : super(const ChartInitialState());

  void getTotalAmount() {
    state = const ChartLoadingState();

    var kontoBox = Hive.box(hiveKontenBox);
    var transaktionBox = Hive.box(hiveTransaktionBox);

    double totalAmount = 0;
    for (Konten konto in kontoBox.values) {
      totalAmount += konto.insgesamt;
    }

    double totalEinnahmen = 0;
    double totalAusgabe = 0;
    for (Transaktion transaktion in transaktionBox.values) {
      if (transaktion.transaktionsType == TransaktionsType.einnahme) {
        totalEinnahmen += transaktion.betrag;
      } else if (transaktion.transaktionsType == TransaktionsType.ausgabe) {
        totalAusgabe += transaktion.betrag;
      }
    }

    state = ChartLoadedState([totalAmount, totalEinnahmen, totalAusgabe]);
  }
}
