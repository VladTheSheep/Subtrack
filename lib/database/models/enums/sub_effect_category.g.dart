// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_effect_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubEffectCategoryAdapter extends TypeAdapter<SubEffectCategory> {
  @override
  final int typeId = 27;

  @override
  SubEffectCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SubEffectCategory.Enhancements;
      case 1:
        return SubEffectCategory.Suppressions;
      case 2:
        return SubEffectCategory.Distortions;
      case 3:
        return SubEffectCategory.Geometry;
      case 4:
        return SubEffectCategory.Hallucinatory;
      case 5:
        return SubEffectCategory.Novel;
      case 6:
        return SubEffectCategory.Psychological;
      case 7:
        return SubEffectCategory.Transpersonal;
      case 8:
        return SubEffectCategory.Alterations;
      case 9:
        return SubEffectCategory.Cardiovascular;
      case 10:
        return SubEffectCategory.Cerebrovascular;
      case 11:
        return SubEffectCategory.Bodily;
      case 12:
        return SubEffectCategory.Misc;
      default:
        return SubEffectCategory.Enhancements;
    }
  }

  @override
  void write(BinaryWriter writer, SubEffectCategory obj) {
    switch (obj) {
      case SubEffectCategory.Enhancements:
        writer.writeByte(0);
        break;
      case SubEffectCategory.Suppressions:
        writer.writeByte(1);
        break;
      case SubEffectCategory.Distortions:
        writer.writeByte(2);
        break;
      case SubEffectCategory.Geometry:
        writer.writeByte(3);
        break;
      case SubEffectCategory.Hallucinatory:
        writer.writeByte(4);
        break;
      case SubEffectCategory.Novel:
        writer.writeByte(5);
        break;
      case SubEffectCategory.Psychological:
        writer.writeByte(6);
        break;
      case SubEffectCategory.Transpersonal:
        writer.writeByte(7);
        break;
      case SubEffectCategory.Alterations:
        writer.writeByte(8);
        break;
      case SubEffectCategory.Cardiovascular:
        writer.writeByte(9);
        break;
      case SubEffectCategory.Cerebrovascular:
        writer.writeByte(10);
        break;
      case SubEffectCategory.Bodily:
        writer.writeByte(11);
        break;
      case SubEffectCategory.Misc:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubEffectCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
