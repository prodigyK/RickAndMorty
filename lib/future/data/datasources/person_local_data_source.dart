import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/future/data/models/person_model.dart';

abstract class PersonLocalDataSource {
  /// Gets the cached [List<PersonModel>]
  ///
  /// Throws [CacheException] if no cache data is present
  Future<List<PersonModel>> getLastPersonsFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}
