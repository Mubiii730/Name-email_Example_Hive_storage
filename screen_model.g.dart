// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Screen_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScreenModelAdapter extends TypeAdapter<ScreenModel> {
  @override
  final int typeId = 0;

  @override
  ScreenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScreenModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScreenModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
