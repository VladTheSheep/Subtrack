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
        return EffectType.positive;
      case 1:
        return EffectType.neutral;
      case 2:
        return EffectType.negative;
      default:
        return EffectType.positive;
    }
  }

  @override
  void write(BinaryWriter writer, EffectType obj) {
    switch (obj) {
      case EffectType.positive:
        writer.writeByte(0);
        break;
      case EffectType.neutral:
        writer.writeByte(1);
        break;
      case EffectType.negative:
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
