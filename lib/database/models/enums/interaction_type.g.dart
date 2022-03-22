// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InteractionTypeAdapter extends TypeAdapter<InteractionType> {
  @override
  final int typeId = 13;

  @override
  InteractionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return InteractionType.Caution;
      case 1:
        return InteractionType.Unsafe;
      case 2:
        return InteractionType.Dangerous;
      case 3:
        return InteractionType.Synergy;
      case 4:
        return InteractionType.Decrease;
      default:
        return InteractionType.Caution;
    }
  }

  @override
  void write(BinaryWriter writer, InteractionType obj) {
    switch (obj) {
      case InteractionType.Caution:
        writer.writeByte(0);
        break;
      case InteractionType.Unsafe:
        writer.writeByte(1);
        break;
      case InteractionType.Dangerous:
        writer.writeByte(2);
        break;
      case InteractionType.Synergy:
        writer.writeByte(3);
        break;
      case InteractionType.Decrease:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
