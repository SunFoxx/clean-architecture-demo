import 'package:equatable/equatable.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manufacturer_response_model.g.dart';

/// The 'outer' container model that is given by vehicles-api
/// Its only purpose is to hold [results] which we need to extract, so this is read-only
/// Because of that, we do not persist this model anywhere in the app
@JsonSerializable(createToJson: false)
class ManufacturerResponseModel extends Equatable {
  @JsonKey(name: 'Count')
  final int count;

  @JsonKey(name: 'Message')
  final String message;

  @JsonKey(name: 'Results')
  final List<ManufacturerModel> results;

  const ManufacturerResponseModel({
    required this.count,
    required this.message,
    required this.results,
  });

  factory ManufacturerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ManufacturerResponseModelFromJson(json);

  @override
  List<Object?> get props => [count, message, results];
}
