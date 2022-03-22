// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effect_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EffectCategoryAdapter extends TypeAdapter<EffectCategory> {
  @override
  final int typeId = 26;

  @override
  EffectCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EffectCategory.Visual;
      case 1:
        return EffectCategory.Cognitive;
      case 2:
        return EffectCategory.Physical;
      case 3:
        return EffectCategory.Auditory;
      case 4:
        return EffectCategory.Disconnective;
      case 5:
        return EffectCategory.Tactile;
      case 6:
        return EffectCategory.SmellTaste;
      case 7:
        return EffectCategory.Multisensory;
      default:
        return EffectCategory.Visual;
    }
  }

  @override
  void write(BinaryWriter writer, EffectCategory obj) {
    switch (obj) {
      case EffectCategory.Visual:
        writer.writeByte(0);
        break;
      case EffectCategory.Cognitive:
        writer.writeByte(1);
        break;
      case EffectCategory.Physical:
        writer.writeByte(2);
        break;
      case EffectCategory.Auditory:
        writer.writeByte(3);
        break;
      case EffectCategory.Disconnective:
        writer.writeByte(4);
        break;
      case EffectCategory.Tactile:
        writer.writeByte(5);
        break;
      case EffectCategory.SmellTaste:
        writer.writeByte(6);
        break;
      case EffectCategory.Multisensory:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EffectCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
