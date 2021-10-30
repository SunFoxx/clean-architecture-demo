import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_response_model.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final tManufacturersModelsPage1 = [
    const ManufacturerModel(
      id: 955,
      name: 'TESLA, INC.',
      country: 'UNITED STATES (USA)',
    ),
    const ManufacturerModel(
      id: 956,
      name: 'ASTON MARTIN LAGONDA LIMITED',
      country: 'UNITED KINGDOM (UK)',
    ),
    const ManufacturerModel(
      id: 957,
      name: 'BMW OF NORTH AMERICA, LLC',
      country: 'UNITED STATES (USA)',
    ),
    const ManufacturerModel(
      id: 958,
      name: 'JAGUAR LAND ROVER NA, LLC',
      country: 'UNITED STATES (USA)',
    ),
  ];
  final tManufacturersResponseModelPage1 = ManufacturerResponseModel(
    count: 4,
    message: 'Response returned successfully',
    results: tManufacturersModelsPage1,
  );

  group('fromJson', () {
    test('should return valid model with list of sub-models when a valid JSON given', () async {
      // arrange
      final jsonMap = jsonDecode(readFixture(Fixture.manufacturersPage1));
      // act
      final model = ManufacturerResponseModel.fromJson(jsonMap);

      // assert
      expect(model, tManufacturersResponseModelPage1);
    });
  });
}
