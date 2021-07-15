// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitments.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommitmentAdapter extends TypeAdapter<Commitment> {
  @override
  final int typeId = 0;

  @override
  Commitment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Commitment(
      name: fields[0] as String,
      description: fields[1] as String,
      value: fields[2] as double,
      label: fields[3] as String,
      billingPeriod: fields[4] as String,
      note: fields[5] as String,
      color: fields[6] as int,
      isCompleted: fields[7] as bool,
      isRecurring: fields[8] as bool,
      isSync: fields[9] as bool,
      isArchive: fields[10] as bool,
      createdAt: fields[11] as DateTime,
      notes: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Commitment obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.billingPeriod)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.color)
      ..writeByte(7)
      ..write(obj.isCompleted)
      ..writeByte(8)
      ..write(obj.isRecurring)
      ..writeByte(9)
      ..write(obj.isSync)
      ..writeByte(10)
      ..write(obj.isArchive)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommitmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
