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
        return EffectCategory.visual;
      case 1:
        return EffectCategory.cognitive;
      case 2:
        return EffectCategory.physical;
      case 3:
        return EffectCategory.auditory;
      case 4:
        return EffectCategory.disconnective;
      case 5:
        return EffectCategory.tactile;
      case 6:
        return EffectCategory.smellTaste;
      case 7:
        return EffectCategory.multisensory;
      default:
        return EffectCategory.visual;
    }
  }

  @override
  void write(BinaryWriter writer, EffectCategory obj) {
    switch (obj) {
      case EffectCategory.visual:
        writer.writeByte(0);
        break;
      case EffectCategory.cognitive:
        writer.writeByte(1);
        break;
      case EffectCategory.physical:
        writer.writeByte(2);
        break;
      case EffectCategory.auditory:
        writer.writeByte(3);
        break;
      case EffectCategory.disconnective:
        writer.writeByte(4);
        break;
      case EffectCategory.tactile:
        writer.writeByte(5);
        break;
      case EffectCategory.smellTaste:
        writer.writeByte(6);
        break;
      case EffectCategory.multisensory:
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
