import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/future/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty/future/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty/future/domain/entities/person_entity.dart';
import 'package:rick_and_morty/future/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return _getPersons(() async {
      final persons = await remoteDataSource.getAllPersons(page);
      localDataSource.personsToCache(persons);
      return persons;
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return _getPersons(() => remoteDataSource.searchPerson(query));
  }

  Future<Either<Failure, List<PersonEntity>>> _getPersons(Future<List<PersonEntity>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePersons = await getPersons();
        return Right(remotePersons);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPersons = await localDataSource.getLastPersonsFromCache();
        return Right(localPersons);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
