// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 25;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      name: fields[0] as String?,
      description: fields[1] as String?,
      wiki: fields[7] as String?,
      tips: (fields[6] as List?)?.cast<dynamic>(),
    )
      ..iconPath = fields[2] as String?
      ..misc = fields[4] as bool?
      ..selected = fields[5] as bool?
      .._color = fields[9] as int;
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.iconPath)
      ..writeByte(4)
      ..write(obj.misc)
      ..writeByte(5)
      ..write(obj.selected)
      ..writeByte(6)
      ..write(obj.tips)
      ..writeByte(7)
      ..write(obj.wiki)
      ..writeByte(9)
      ..write(obj._color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
