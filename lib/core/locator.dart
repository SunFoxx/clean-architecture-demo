import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jimmy_test/core/errors/usecases/map_error_to_message.dart';
import 'package:jimmy_test/core/localization/en/en_strings.dart';
import 'package:jimmy_test/core/logger/logger_factory.dart';
import 'package:jimmy_test/core/network/network_client.dart';
import 'package:jimmy_test/core/network/network_info.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_local_data_source.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_remote_datasource.dart';
import 'package:jimmy_test/features/makes/data/repositories/makes_repository.dart';
import 'package:jimmy_test/features/makes/domain/repositories/makes_repository.dart';
import 'package:jimmy_test/features/makes/domain/usecases/load_makes_by_manufacturer_id.dart';
import 'package:jimmy_test/features/makes/presentation/bloc/makes_bloc.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_local_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_remote_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/repositories/manufacturers_repository.dart';
import 'package:jimmy_test/features/manufacturers/domain/repositories/manufacturers_repository.dart';
import 'package:jimmy_test/features/manufacturers/domain/usecases/load_manufacturers.dart';
import 'package:jimmy_test/features/manufacturers/presentation/bloc/manufacturers_bloc.dart';
import 'package:logger/logger.dart';

import 'localization/string_provider.dart';

/// Dependency injection container reference
final locator = GetIt.instance;

/// Basically, the entry point of all app's dependencies
/// Here we inject all implementations of business logic abstractions
Future initLocator() async {
  _initCore();
  _initManufacturers();
  _initMakes();
}

void _initCore() {
  locator.registerLazySingleton<Logger>(() => LoggerFactory.getLogger());
  locator.registerLazySingleton<VehiclesApiClient>(
      () => VehiclesApiClient()..configureVehiclesApiClient());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));
  locator.registerLazySingleton(() => StringProvider(EnStrings()));

  locator.registerLazySingleton(() => MapErrorToMessage(locator.get()));
}

void _initManufacturers() {
  locator.registerLazySingleton<ManufacturersLocalDataSource>(
      () => ManufacturersHiveLocalDataSource());
  locator.registerLazySingleton<ManufacturersRemoteDataSource>(
      () => ManufacturersApiRemoteDataSource(client: locator.get<VehiclesApiClient>().client));
  locator.registerLazySingleton<ManufacturersRepository>(() => ManufacturersRepositoryImpl(
        networkInfo: locator.get(),
        localDataSource: locator.get(),
        remoteDataSource: locator.get(),
      ));
  locator
      .registerLazySingleton<LoadManufacturers>(() => LoadManufacturers(repository: locator.get()));
  locator.registerFactory(() => ManufacturersBloc(
        loadManufacturers: locator.get(),
        mapErrorToMessage: locator.get(),
      ));
}

void _initMakes() {
  locator.registerLazySingleton<MakesRemoteDataSource>(
      () => MakesApiRemoteDataSource(client: locator.get<VehiclesApiClient>().client));
  locator.registerLazySingleton<MakesLocalDataSource>(() => MakesHiveLocalDataSource());
  locator.registerLazySingleton<MakesRepository>(() => MakesRepositoryImpl(
        networkInfo: locator.get(),
        localDataSource: locator.get(),
        remoteDataSource: locator.get(),
      ));
  locator.registerLazySingleton(() => LoadMakesByManufacturersId(makesRepository: locator.get()));
  locator.registerFactory(() => MakesBloc(
        loadMakesByManufacturersId: locator.get(),
        mapErrorToMessage: locator.get(),
      ));
}
