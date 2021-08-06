import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/future/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty/future/data/datasources/person_local_data_source_impl.dart';
import 'package:rick_and_morty/future/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty/future/data/datasources/person_remote_data_source_impl.dart';
import 'package:rick_and_morty/future/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty/future/domain/repositories/person_repository.dart';
import 'package:rick_and_morty/future/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/future/domain/usecases/search_person.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_cubit/persons_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerFactory(() => PersonCubit(serviceLocator()));
  serviceLocator.registerFactory(() => PersonSearchBlock(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetAllPersons(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SearchPerson(serviceLocator()));

  serviceLocator.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<PersonRemoteDataSource>(() => PersonRemoteDataSourseImpl());
  serviceLocator.registerLazySingleton<PersonLocalDataSource>(() => PersonLocalDataSourceImpl(sharedPreferences: serviceLocator()));
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
