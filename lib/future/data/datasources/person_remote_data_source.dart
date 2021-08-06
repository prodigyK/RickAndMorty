import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/future/data/models/person_model.dart';


abstract class PersonRemoteDataSource {
  /// https://rickandmortyapi.com/api/character/?page=1
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<PersonModel>> getAllPersons(int page);

  /// https://rickandmortyapi.com/api/character/?name=rick
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<PersonModel>> searchPerson(String query);
}

