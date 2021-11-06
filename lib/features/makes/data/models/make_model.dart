import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:jimmy_test/features/makes/domain/entities/make.dart';
import 'package:json_annotation/json_annotation.dart';

part 'make_model.g.dart';

/// Predecessor model of [Make] entity
/// Generally, we parse this one out of the vehicles-api responses,
/// but also we persist this model since we have to load it from remote, which may fail
@HiveType(typeId: 2)
@JsonSerializable(createToJson: false)
class MakeModel extends Equatable {
  @HiveField(0)
  @JsonKey(name: 'Make_ID')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'Make_Name')
  final String name;

  @HiveField(2)
  @JsonKey(name: 'Mfr_Name')
  final String manufacturerName;

  const MakeModel({
    required this.id,
    required this.name,
    required this.manufacturerName,
  });

  factory MakeModel.fromJson(Map<String, dynamic> json) => _$MakeModelFromJson(json);

  @override
  List<Object?> get props => [id, name, manufacturerName];
}
