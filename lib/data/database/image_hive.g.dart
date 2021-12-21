// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageDaoAdapter extends TypeAdapter<ImageDao> {
  @override
  final int typeId = 0;

  @override
  ImageDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageDao(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageDao obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.downloadUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
