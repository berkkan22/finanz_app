import 'package:hive/hive.dart';

part 'konten.g.dart';

// Generate Adapter: flutter packages pub run build_runner build

@HiveType(typeId: 0)
class Konten {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final KontoType type; // Konto, Unterkonto

  @HiveField(3)
  final bool isHauptKonto;

  @HiveField(6)
  final double insgesamt;

  @HiveField(7)
  final int color;

  @HiveField(8)
  final int order;

  Konten({
    this.id,
    required this.name,
    required this.type,
    required this.isHauptKonto,
    required this.insgesamt,
    required this.color,
    required this.order,
  });
}

@HiveType(typeId: 1)
class Transaktion {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final DateTime datum;

  @HiveField(3)
  final double betrag;

  @HiveField(4)
  final VorgangsType vorgangsType;

  @HiveField(5)
  final int? abbuchungsDatum;

  @HiveField(6)
  final TransaktionsType transaktionsType;

  @HiveField(7)
  final Kategorie? kategorie;

  @HiveField(8)
  final int vonKontoId;

  @HiveField(9)
  final int? nachKontoId;

  Transaktion({
    this.id,
    this.name,
    required this.datum,
    required this.betrag,
    required this.vorgangsType,
    this.abbuchungsDatum,
    required this.transaktionsType,
    this.kategorie,
    required this.vonKontoId,
    this.nachKontoId,
  });
}

@HiveType(typeId: 3)
enum KontoType {
  @HiveField(0)
  konto,
  @HiveField(1)
  unterKonto,
  @HiveField(2)
  addButton,
  @HiveField(3)
  edelmetallKonto
}

@HiveType(typeId: 4)
enum VorgangsType {
  @HiveField(0)
  ueberweisung,
  @HiveField(1)
  dauerauftrag,
  @HiveField(2)
  transfer
}

@HiveType(typeId: 5)
enum TransaktionsType {
  @HiveField(0)
  einnahme,
  @HiveField(1)
  ausgabe
}

/// shoping
/// Muss auch eine class sein damit man es einspeichern kann
@HiveType(typeId: 6)
enum Kategorie {
  @HiveField(0)
  shopping,

  @HiveField(1)
  food,

  @HiveField(2)
  bills,

  @HiveField(3)
  entertainment,

  @HiveField(4)
  transport,

  @HiveField(5)
  medikamente,

  @HiveField(6)
  addOwn,
}

extension ParseToNameKategorie on Kategorie {
  String toName() {
    return "${toString().split('.').last[0].toUpperCase()}${toString().substring(11).toLowerCase()}";
  }
}

extension ParseToNameKonto on Konten {
  String toName() {
    return name.toString();
  }
}
