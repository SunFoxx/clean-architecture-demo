import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_response_model.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';

/// Contains prepared models accordingly to corresponding fixtures (and more)
class ManufacturersTestModels {
  static const tManufacturerModelsPage1 = [
    ManufacturerModel(
      id: 955,
      name: 'TESLA, INC.',
      country: 'UNITED STATES (USA)',
    ),
    ManufacturerModel(
      id: 956,
      name: 'ASTON MARTIN LAGONDA LIMITED',
      country: 'UNITED KINGDOM (UK)',
    ),
    ManufacturerModel(
      id: 957,
      name: 'BMW OF NORTH AMERICA, LLC',
      country: 'UNITED STATES (USA)',
    ),
    ManufacturerModel(
      id: 958,
      name: 'JAGUAR LAND ROVER NA, LLC',
      country: 'UNITED STATES (USA)',
    ),
  ];

  static const tManufacturerResponseModelPage1 = ManufacturerResponseModel(
    count: 4,
    message: 'Response returned successfully',
    results: tManufacturerModelsPage1,
  );

  static const tManufacturerEntitiesPage1 = [
    Manufacturer(
      id: 955,
      name: 'TESLA, INC.',
      country: 'UNITED STATES (USA)',
    ),
    Manufacturer(
      id: 956,
      name: 'ASTON MARTIN LAGONDA LIMITED',
      country: 'UNITED KINGDOM (UK)',
    ),
    Manufacturer(
      id: 957,
      name: 'BMW OF NORTH AMERICA, LLC',
      country: 'UNITED STATES (USA)',
    ),
    Manufacturer(
      id: 958,
      name: 'JAGUAR LAND ROVER NA, LLC',
      country: 'UNITED STATES (USA)',
    ),
  ];

  static const tManufacturerEntitiesPage2 = [
    Manufacturer(
      id: 959,
      name: 'FORD',
      country: 'UNITED STATES (USA)',
    ),
    Manufacturer(
      id: 960,
      name: 'LADA',
      country: 'RUSSIAN FEDERATION',
    ),
  ];

  static const tManufacturerEntitiesPage3 = <Manufacturer>[];
}
