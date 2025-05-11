// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetItemsModelAdapter extends TypeAdapter<GetItemsModel> {
  @override
  final int typeId = 0;

  @override
  GetItemsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetItemsModel(
      itemId: fields[0] as String?,
      itemName: fields[1] as String?,
      itemDescription: fields[2] as String?,
      itemPrice: fields[3] as int?,
      itemYear: fields[4] as int?,
      itemBrand: fields[5] as String?,
      imageUrl: fields[6] as String?,
      userId: fields[7] as String?,
      imageFile: fields[8] as dynamic,
      createdAt: fields[9] as String?,
      additionalImageUrls: (fields[10] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GetItemsModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.itemId)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.itemDescription)
      ..writeByte(3)
      ..write(obj.itemPrice)
      ..writeByte(4)
      ..write(obj.itemYear)
      ..writeByte(5)
      ..write(obj.itemBrand)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.userId)
      ..writeByte(8)
      ..write(obj.imageFile)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.additionalImageUrls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetItemsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
