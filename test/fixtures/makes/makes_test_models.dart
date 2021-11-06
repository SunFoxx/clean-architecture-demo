import 'package:jimmy_test/features/makes/data/models/make_model.dart';
import 'package:jimmy_test/features/makes/data/models/makes_response_model.dart';
import 'package:jimmy_test/features/makes/domain/entities/make.dart';

/// Contains prepared models accordingly to corresponding fixtures
class MakesTestModels {
  static const tManufacturerId = 987;

  static const tMakeModels987 = [
    MakeModel(
      id: 474,
      name: "HONDA",
      manufacturerName: "HONDA MOTOR CO., LTD",
    ),
    MakeModel(
      id: 475,
      name: "ACURA",
      manufacturerName: "HONDA MOTOR CO., LTD",
    ),
    MakeModel(
      id: 542,
      name: "ISUZU",
      manufacturerName: "HONDA MOTOR CO., LTD",
    ),
  ];

  static const tMakeResponseModel987 = MakesResponseModel(
    count: 3,
    message: 'Results returned successfully',
    results: tMakeModels987,
  );

  static const tMakeEntities987 = [
    Make(name: 'HONDA', id: 474),
    Make(name: 'ACURA', id: 475),
    Make(name: 'ISUZU', id: 542),
  ];
}
