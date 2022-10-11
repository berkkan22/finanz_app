// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'konten.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KontenAdapter extends TypeAdapter<Konten> {
  @override
  final int typeId = 0;

  @override
  Konten read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Konten(
      id: fields[0] as int?,
      name: fields[1] as String,
      type: fields[2] as KontoType,
      isHauptKonto: fields[3] as bool,
      insgesamt: fields[6] as double,
      color: fields[7] as int,
      order: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Konten obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.isHauptKonto)
      ..writeByte(6)
      ..write(obj.insgesamt)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KontenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransaktionAdapter extends TypeAdapter<Transaktion> {
  @override
  final int typeId = 1;

  @override
  Transaktion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaktion(
      id: fields[0] as int?,
      name: fields[1] as String?,
      datum: fields[2] as DateTime,
      betrag: fields[3] as double,
      vorgangsType: fields[4] as VorgangsType,
      abbuchungsDatum: fields[5] as int?,
      transaktionsType: fields[6] as TransaktionsType,
      kategorie: fields[7] as Kategorie?,
      vonKontoId: fields[8] as int,
      nachKontoId: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Transaktion obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.datum)
      ..writeByte(3)
      ..write(obj.betrag)
      ..writeByte(4)
      ..write(obj.vorgangsType)
      ..writeByte(5)
      ..write(obj.abbuchungsDatum)
      ..writeByte(6)
      ..write(obj.transaktionsType)
      ..writeByte(7)
      ..write(obj.kategorie)
      ..writeByte(8)
      ..write(obj.vonKontoId)
      ..writeByte(9)
      ..write(obj.nachKontoId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransaktionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KontoTypeAdapter extends TypeAdapter<KontoType> {
  @override
  final int typeId = 3;

  @override
  KontoType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return KontoType.konto;
      case 1:
        return KontoType.unterKonto;
      case 2:
        return KontoType.addButton;
      case 3:
        return KontoType.edelmetallKonto;
      default:
        return KontoType.konto;
    }
  }

  @override
  void write(BinaryWriter writer, KontoType obj) {
    switch (obj) {
      case KontoType.konto:
        writer.writeByte(0);
        break;
      case KontoType.unterKonto:
        writer.writeByte(1);
        break;
      case KontoType.addButton:
        writer.writeByte(2);
        break;
      case KontoType.edelmetallKonto:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KontoTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VorgangsTypeAdapter extends TypeAdapter<VorgangsType> {
  @override
  final int typeId = 4;

  @override
  VorgangsType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VorgangsType.ueberweisung;
      case 1:
        return VorgangsType.dauerauftrag;
      case 2:
        return VorgangsType.transfer;
      default:
        return VorgangsType.ueberweisung;
    }
  }

  @override
  void write(BinaryWriter writer, VorgangsType obj) {
    switch (obj) {
      case VorgangsType.ueberweisung:
        writer.writeByte(0);
        break;
      case VorgangsType.dauerauftrag:
        writer.writeByte(1);
        break;
      case VorgangsType.transfer:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VorgangsTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransaktionsTypeAdapter extends TypeAdapter<TransaktionsType> {
  @override
  final int typeId = 5;

  @override
  TransaktionsType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransaktionsType.einnahme;
      case 1:
        return TransaktionsType.ausgabe;
      default:
        return TransaktionsType.einnahme;
    }
  }

  @override
  void write(BinaryWriter writer, TransaktionsType obj) {
    switch (obj) {
      case TransaktionsType.einnahme:
        writer.writeByte(0);
        break;
      case TransaktionsType.ausgabe:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransaktionsTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KategorieAdapter extends TypeAdapter<Kategorie> {
  @override
  final int typeId = 6;

  @override
  Kategorie read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Kategorie.shopping;
      case 1:
        return Kategorie.food;
      case 2:
        return Kategorie.bills;
      case 3:
        return Kategorie.entertainment;
      case 4:
        return Kategorie.transport;
      case 5:
        return Kategorie.addOwn;
      default:
        return Kategorie.shopping;
    }
  }

  @override
  void write(BinaryWriter writer, Kategorie obj) {
    switch (obj) {
      case Kategorie.shopping:
        writer.writeByte(0);
        break;
      case Kategorie.food:
        writer.writeByte(1);
        break;
      case Kategorie.bills:
        writer.writeByte(2);
        break;
      case Kategorie.entertainment:
        writer.writeByte(3);
        break;
      case Kategorie.transport:
        writer.writeByte(4);
        break;
      case Kategorie.addOwn:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KategorieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
