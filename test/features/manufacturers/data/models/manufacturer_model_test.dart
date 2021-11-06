import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_response_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/manufacturers/manufacturers_test_models.dart';

main() {
  const tManufacturersModelsPage1 = ManufacturersTestModels.tManufacturerModelsPage1;
  const tManufacturersResponseModelPage1 = ManufacturersTestModels.tManufacturerResponseModelPage1;

  group('fromJson', () {
    test('should return valid model with list of sub-models when a valid JSON given', () async {
      // arrange
      final jsonMap = jsonDecode(readFixture(Fixture.manufacturersPage1));
      // act
      final model = ManufacturerResponseModel.fromJson(jsonMap);

      // assert
      expect(model, tManufacturersResponseModelPage1);
      expect(model.results, tManufacturersModelsPage1);
    });
  });
}
