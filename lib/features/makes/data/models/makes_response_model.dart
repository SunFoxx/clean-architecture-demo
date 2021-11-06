import 'package:equatable/equatable.dart';
import 'package:jimmy_test/features/makes/data/models/make_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'makes_response_model.g.dart';

@JsonSerializable(createToJson: false)
class MakesResponseModel<T> extends Equatable {
  @JsonKey(name: 'Count')
  final int count;

  @JsonKey(name: 'Message')
  final String message;

  @JsonKey(name: 'Results')
  final List<MakeModel> results;

  factory MakesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MakesResponseModelFromJson(json);

  const MakesResponseModel({
    required this.count,
    required this.message,
    required this.results,
  });

  @override
  List<Object?> get props => [count, message, results];
}
