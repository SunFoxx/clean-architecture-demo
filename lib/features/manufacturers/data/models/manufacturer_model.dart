import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manufacturer_model.g.dart';

/// Predecessor model of [Manufacturer] entity
/// Generally, we parse this one out of the vehicles-api responses,
/// but also we persist this particular model since we have to load hundreds of them from remote, which may fail
@HiveType(typeId: 1)
@JsonSerializable(createToJson: false)
class ManufacturerModel extends Equatable {
  @HiveField(0)
  @JsonKey(name: 'Mfr_ID')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'Mfr_Name')
  final String name;

  @HiveField(2)
  @JsonKey(name: 'Country')
  final String country;

  const ManufacturerModel({
    required this.id,
    required this.name,
    required this.country,
  });

  factory ManufacturerModel.fromJson(Map<String, dynamic> json) =>
      _$ManufacturerModelFromJson(json);

  @override
  List<Object?> get props => [id, name, country];
}
