// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_view_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyViewModelAdapter extends TypeAdapter<RecentlyViewModel> {
  @override
  final int typeId = 1;

  @override
  RecentlyViewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyViewModel(
      itemId: fields[0] as String?,
      itemName: fields[1] as String?,
      imageUrl: fields[2] as String?,
      userId: fields[3] as dynamic,
      viewedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyViewModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.itemId)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.viewedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyViewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
