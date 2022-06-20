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
        return InteractionType.caution;
      case 1:
        return InteractionType.unsafe;
      case 2:
        return InteractionType.dangerous;
      case 3:
        return InteractionType.synergy;
      case 4:
        return InteractionType.decrease;
      default:
        return InteractionType.caution;
    }
  }

  @override
  void write(BinaryWriter writer, InteractionType obj) {
    switch (obj) {
      case InteractionType.caution:
        writer.writeByte(0);
        break;
      case InteractionType.unsafe:
        writer.writeByte(1);
        break;
      case InteractionType.dangerous:
        writer.writeByte(2);
        break;
      case InteractionType.synergy:
        writer.writeByte(3);
        break;
      case InteractionType.decrease:
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
