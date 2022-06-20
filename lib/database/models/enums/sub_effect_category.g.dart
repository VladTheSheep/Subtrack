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
        return SubEffectCategory.enhancements;
      case 1:
        return SubEffectCategory.suppressions;
      case 2:
        return SubEffectCategory.distortions;
      case 3:
        return SubEffectCategory.geometry;
      case 4:
        return SubEffectCategory.hallucinatory;
      case 5:
        return SubEffectCategory.novel;
      case 6:
        return SubEffectCategory.psychological;
      case 7:
        return SubEffectCategory.transpersonal;
      case 8:
        return SubEffectCategory.alterations;
      case 9:
        return SubEffectCategory.cardiovascular;
      case 10:
        return SubEffectCategory.cerebrovascular;
      case 11:
        return SubEffectCategory.bodily;
      case 12:
        return SubEffectCategory.misc;
      default:
        return SubEffectCategory.enhancements;
    }
  }

  @override
  void write(BinaryWriter writer, SubEffectCategory obj) {
    switch (obj) {
      case SubEffectCategory.enhancements:
        writer.writeByte(0);
        break;
      case SubEffectCategory.suppressions:
        writer.writeByte(1);
        break;
      case SubEffectCategory.distortions:
        writer.writeByte(2);
        break;
      case SubEffectCategory.geometry:
        writer.writeByte(3);
        break;
      case SubEffectCategory.hallucinatory:
        writer.writeByte(4);
        break;
      case SubEffectCategory.novel:
        writer.writeByte(5);
        break;
      case SubEffectCategory.psychological:
        writer.writeByte(6);
        break;
      case SubEffectCategory.transpersonal:
        writer.writeByte(7);
        break;
      case SubEffectCategory.alterations:
        writer.writeByte(8);
        break;
      case SubEffectCategory.cardiovascular:
        writer.writeByte(9);
        break;
      case SubEffectCategory.cerebrovascular:
        writer.writeByte(10);
        break;
      case SubEffectCategory.bodily:
        writer.writeByte(11);
        break;
      case SubEffectCategory.misc:
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
