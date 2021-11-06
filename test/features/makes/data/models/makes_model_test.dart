import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/features/makes/data/models/makes_response_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/makes/makes_test_models.dart';

main() {
  final tMakeModels = MakesTestModels.tMakeModels987;
  final tMakesResponseModel = MakesTestModels.tMakeResponseModel987;

  group('fromJson', () {
    test('should return valid model with list of sub-models when a valid JSON given', () async {
      // arrange
      final jsonMap = jsonDecode(readFixture(Fixture.makes_for_id987));

      // act
      final model = MakesResponseModel.fromJson(jsonMap);

      // assert
      expect(model, tMakesResponseModel);
      expect(model.results, tMakeModels);
    });
  });
}
