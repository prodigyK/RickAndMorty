import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/future/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty/future/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String PERSON_CACHED_LIST = 'PERSON_CACHED_LIST';

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final personlist = sharedPreferences.getStringList(PERSON_CACHED_LIST) ?? [];
    if (personlist.isNotEmpty) {
      final List<PersonModel> personModelList = personlist.map((string) {
        return PersonModel.fromJson(json.decode(string) as Map<String, dynamic>);
      }).toList();
      return Future.value(personModelList);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) async {
    final List<String> jsonPersonsList = persons.map((person) => json.encode(person.toJson())).toList();
    await sharedPreferences.setStringList(PERSON_CACHED_LIST, jsonPersonsList);
  }
}
