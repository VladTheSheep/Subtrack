// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effect_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EffectTypeAdapter extends TypeAdapter<EffectType> {
  @override
  final int typeId = 28;

  @override
  EffectType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EffectType.Positive;
      case 1:
        return EffectType.Neutral;
      case 2:
        return EffectType.Negative;
      default:
        return EffectType.Positive;
    }
  }

  @override
  void write(BinaryWriter writer, EffectType obj) {
    switch (obj) {
      case EffectType.Positive:
        writer.writeByte(0);
        break;
      case EffectType.Neutral:
        writer.writeByte(1);
        break;
      case EffectType.Negative:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EffectTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
