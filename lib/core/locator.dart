import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jimmy_test/core/network/network_client.dart';
import 'package:jimmy_test/core/network/network_info.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_local_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_remote_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/repositories/manufacturers_repository.dart';
import 'package:jimmy_test/features/manufacturers/domain/repositories/manufacturers_repository.dart';
import 'package:jimmy_test/features/manufacturers/domain/usecases/load_manufacturers.dart';
import 'package:jimmy_test/features/manufacturers/presentation/bloc/manufacturers_bloc.dart';

/// Dependency injection container reference
final locator = GetIt.instance;

/// Basically, the entry point of all app's dependencies
/// Here we inject all implementations of business logic abstractions
Future initLocator() async {
  _initCore();
  _initManufacturers();
}

void _initCore() {
  locator.registerLazySingleton<VehiclesApiClient>(
      () => VehiclesApiClient()..configureVehiclesApiClient());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));
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
  locator.registerFactory(() => ManufacturersBloc(loadManufacturers: locator.get()));
}
